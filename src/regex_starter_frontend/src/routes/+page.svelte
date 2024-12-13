<script>
  import "../index.scss";
  import { backend } from "$lib/canisters";
  import { slide, fade } from 'svelte/transition';
  
  let regexPattern = "";
  let testString = "";
  let result = "";
  let errorMessage = "";
  let tooltipVisible = false;
  let modeTooltipVisible = false;
  let caseSensitive = true;
  let multiline = false;
  let mode = "match";
  let isLoading = false;
  
  async function onSubmit(event) {
    event.preventDefault();
    isLoading = true;
    result = "";
    errorMessage = "";
    
    try {
      const flags = [{ 
        caseSensitive: caseSensitive,
        multiline: multiline
      }];

      switch (mode) {
        case "match":
          result = await backend.match(regexPattern, flags, testString);
          break;
        case "search":
          result = await backend.search(regexPattern, flags, testString);
          break;
        case "findAll":
          result = await backend.findAll(regexPattern, flags, testString);
          break;
      }

      if (result.includes("No matches found")) {
        errorMessage = "No matches found.";
        result = "";
      }
    } catch (error) {
      console.error("Regex processing error:", error);
      errorMessage = `Error processing request: ${error.message}`;
      result = "";
    } finally {
      isLoading = false;
    }
  }
</script>

<main>
  <div class="search-box-container">
  <div class="motoko">
    <img src="mo.png" alt="Motoko" />
  </div>
  <div class="search-box">
    <h1>Motoko Regex Engine</h1>
    <form on:submit|preventDefault={onSubmit}>
      <div class="input-group">
        <label for="regexPattern">Regular Expression</label>
        <input
          id="regexPattern"
          type="text"
          bind:value={regexPattern}
          placeholder="Enter regex pattern..."
        />
      </div>

      <fieldset class="flags">
        <label>
          <input type="checkbox" class="cb" bind:checked={caseSensitive} />
          <i></i>
          <span>Case Sensitive</span>
        </label>
        <label>
          <input type="checkbox" class="cb" bind:checked={multiline} />
          <i></i>
          <span>Multiline</span>
        </label>
        <div class="flags-header">
          <div class="tooltip-container">
            <!-- svelte-ignore a11y-no-static-element-interactions -->
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <svg 
              xmlns="http://www.w3.org/2000/svg" 
              class="info-icon" 
              viewBox="0,0,256,256" 
              width="20"
              height="20"
              on:click={() => tooltipVisible = !tooltipVisible}
              on:mouseenter={() => tooltipVisible = true}
              on:mouseleave={() => tooltipVisible = false}
            >
              <g fill="#3b00b9" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal">
                <g transform="scale(5.12,5.12)">
                  <path d="M25,2c-12.6907,0 -23,10.3093 -23,23c0,12.69071 10.3093,23 23,23c12.69071,0 23,-10.30929 23,-23c0,-12.6907 -10.30929,-23 -23,-23zM25,4c11.60982,0 21,9.39018 21,21c0,11.60982 -9.39018,21 -21,21c-11.60982,0 -21,-9.39018 -21,-21c0,-11.60982 9.39018,-21 21,-21zM25,11c-1.65685,0 -3,1.34315 -3,3c0,1.65685 1.34315,3 3,3c1.65685,0 3,-1.34315 3,-3c0,-1.65685 -1.34315,-3 -3,-3zM21,21v2h1h1v13h-1h-1v2h1h1h4h1h1v-2h-1h-1v-15h-1h-4z"></path>
                </g>
              </g>
            </svg>
            {#if tooltipVisible}
              <div class="tooltip">
                <strong>Regex Flags:</strong><br>
                <strong>Case Sensitive:</strong> When enabled, the pattern matching will be case-sensitive (e.g., 'A' ≠ 'a') Engine is case sensitive by default!<br>
                <strong>Multiline:</strong> When enabled, '^' and '$' match the start/end of each line, not just the whole string (^abc matches \nabc).
              </div>
            {/if}
          </div>
        </div>
      </fieldset>

      <div class="input-group">
        <label for="testString">Test String</label>
        <input
          id="testString"
          type="text"
          bind:value={testString}
          placeholder="Enter test string..."
        />
      </div>

      <div class="modes">
        <div class="switch">
          <input name="mode" id="match" type="radio" bind:group={mode} value="match" checked/>
          <label for="match" class="switch__label">Match</label>
          
          <input name="mode" id="search" type="radio" bind:group={mode} value="search" />
          <label for="search" class="switch__label">Search</label>
          
          <input name="mode" id="findAll" type="radio" bind:group={mode} value="findAll" />
          <label for="findAll" class="switch__label">Find All</label>
          
          <div class="info-container">
            <!-- svelte-ignore a11y-click-events-have-key-events -->
            <!-- svelte-ignore a11y-no-static-element-interactions -->
            <svg 
              xmlns="http://www.w3.org/2000/svg" 
              class="info-icon" 
              viewBox="0,0,256,256" 
              width="20" 
              height="20"
              on:click={() => modeTooltipVisible = !modeTooltipVisible}
              on:mouseenter={() => modeTooltipVisible = true}
              on:mouseleave={() => modeTooltipVisible = false}
            >
              <g fill="#3b00b9" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal">
                <g transform="scale(5.12,5.12)">
                  <path d="M25,2c-12.6907,0 -23,10.3093 -23,23c0,12.69071 10.3093,23 23,23c12.69071,0 23,-10.30929 23,-23c0,-12.6907 -10.30929,-23 -23,-23zM25,4c11.60982,0 21,9.39018 21,21c0,11.60982 -9.39018,21 -21,21c-11.60982,0 -21,-9.39018 -21,-21c0,-11.60982 9.39018,-21 21,-21zM25,11c-1.65685,0 -3,1.34315 -3,3c0,1.65685 1.34315,3 3,3c1.65685,0 3,-1.34315 3,-3c0,-1.65685 -1.34315,-3 -3,-3zM21,21v2h1h1v13h-1h-1v2h1h1h4h1h1v-2h-1h-1v-15h-1h-4z"></path>
                </g>
              </g>
            </svg>
            {#if modeTooltipVisible}
              <div class="tooltip">
                <strong>Functions:</strong><br>
                <strong>Match:</strong> The string must match the pattern exactly<br>
                <strong>Search:</strong> Returns the first valid match found<br>
                <strong>Find All:</strong> Returns all valid matches in the string
              </div>
            {/if}
          </div>
          
          <div class="switch__indicator" />
        </div>
      </div>

      <button type="submit">Test</button>
    </form>

    {#if errorMessage}
      <p class="error">{errorMessage}</p>
    {/if}

    {#if isLoading}
    <div class="loader-container" in:fade={{ duration: 200 }} out:fade={{ duration: 200 }}>
      <div class="loader"></div>
      <span>Processing...</span>
    </div>
  {/if}

  {#if errorMessage}
    <p class="error" in:slide={{ duration: 300 }} out:slide={{ duration: 300 }}>
      {errorMessage}
    </p>
  {/if}

  <section class="result-container">
    {#if result}
      <div class="result" in:slide={{ duration: 300 }} out:slide={{ duration: 300 }}>
        <h2>Result</h2>
        <pre class="result-text">{result}</pre>
      </div>
    {/if}
  </section>
</div>
<div class="ic-badge">
  <img src="powered.png" alt="Powered by Internet Computer" />
</div>
</div>
</main>
<svelte:head>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
</svelte:head>
<style>
  :global(*), :global(*:before), :global(*:after) {
    box-sizing: border-box;
  }
  :global(*) {
    font-family: 'DM Sans', sans-serif;
  }

  h1 {
    font-weight: 700;
  }

  .switch__label {
    font-weight: 500;
  }

  input[type="text"]::placeholder {
    font-family: 'DM Sans', sans-serif;
    font-weight: 400;
  }
  :global(body) {
    margin: 0;
    padding: 0;
    min-height: 100vh;
    background: linear-gradient(135deg, #C0D9FF, #F0B9E5);
    font-size: 16px;
  }

  main {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  padding: 2rem 1rem;
  color: #181818;
  font-family: Arial, sans-serif;
  position: relative;
}

.search-box-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 500px;
  gap: 1rem;
}
.search-box {
  background: white;
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
  width: 100%;
}
  h1 {
    text-align: center;
    margin-bottom: 1rem;
  }

  .input-group {
    margin-bottom: 1rem;
    text-align: left;
  }
  .input-group label {
    display: block;
    margin-bottom: 0.5rem;
  }
  input[type="text"] {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
  }
  .flags {
    display: flex;
    justify-content: flex-start;
    gap: 2rem;
    margin: 1rem 0;
    padding: 1rem;
    border: none;
  }

  .flags label {
    font-size: 0.9rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .flags input {
    display: none;
  }

  .flags i {
    display: inline-block;
    width: 44px;
    height: 24px;
    border-radius: 12px;
    vertical-align: middle;
    transition: 0.25s;
    position: relative;
    background: #deeff7;
  }

  .flags i:after {
    content: "";
    display: block;
    width: 18px;
    height: 18px;
    top: 3px;
    left: 3px;
    border-radius: 50%;
    background: #fff;
    position: absolute;
    box-shadow: 1px 2px 4px 0 rgba(0, 0, 0, 0.4);
    transition: 0.15s;
  }

  .flags span {
    color: #522785;
  }

  .flags input:checked + i {
    background: #3b00b9;
  }

  .flags input:checked + i:after {
    transform: translateX(20px);
  }

  .flags input:checked + i + span {
    color: #181818;
  }
  .tooltip-container {
  position: relative;
  display: inline-block;
}

.info-icon {
  cursor: pointer;
  transition: opacity 0.2s;
}

.info-icon:hover {
  opacity: 0.8;
}

.tooltip {
  position: absolute;
  top: calc(100% + 10px);
  left: 0;
  background: white;
  border: 1px solid #e0e0e0;
  padding: 1rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  width: 300px;
  z-index: 1000;
  font-size: 0.875rem;
  line-height: 1.5;
  color: #333;
}

.tooltip::before {
  content: '';
  position: absolute;
  top: -6px;
  left: 10px;
  width: 12px;
  height: 12px;
  background: white;
  transform: rotate(45deg);
  border-left: 1px solid #e0e0e0;
  border-top: 1px solid #e0e0e0;
}
  .modes {
  display: flex;
  justify-content: flex-start;
  margin: 1rem 0;
  padding: 0 1rem;
}
.switch {
  position: relative;
  width: 14rem;
  height: 2rem;
  padding: 0;
  margin-left: 0;
}

.switch:before {
  content: ' ';
  position: absolute;
  left: 0;
  z-index: -1;
  width: 100%;
  height: 2rem;
  background: #deeff7;
  border-radius: 30px;
}

.switch__label {
  display: inline-block;
  width: auto;
  min-width: 3.5rem;
  padding: 0.5rem 0.75rem;
  text-align: center;
  cursor: pointer;
  transition: color 200ms ease-out;
  color: #522785;
  font-size: 0.9rem;
  font-weight: 500;
}

.switch__indicator {
  width: 4rem;
  height: 2rem;
  position: absolute;
  top: 0;
  left: 0;
  background: #3b00b9;
  border-radius: 30px;
  transition: transform 600ms cubic-bezier(.02,.94,.09,.97),
              background 300ms cubic-bezier(.17,.67,.14,1.03);
  transform: translate3d(0,0,0);
}

input#match:checked ~ .switch__indicator {
  transform: translate3d(0.2,0,0);
}

input#search:checked ~ .switch__indicator {
  transform: translate3d(4.55rem,0,0);
}
input#findAll:checked ~ .switch__indicator {
  transform: translate3d(9.5rem,0,0);
}
.input-group, .flags, .modes {
  padding: 0 1rem;  
}  input[type="radio"]:not(:checked),
  input[type="radio"]:checked {
    display: none;
  }

  input#match:checked ~ label[for="match"],
  input#search:checked ~ label[for="search"],
  input#findAll:checked ~ label[for="findAll"] {
    color: white;
    z-index: 1;
    position: relative;
  }
  button {
    display: block;
    width: auto;
    margin-top: 1.5rem;
    padding: 0.75rem;
    background-color: #3b00b9;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  button:hover {
    background-color: #1e005d;
  }
  .error {
    color: #ed1e79;
    font-weight: bold;
    margin-top: 1rem;
    text-align: center;
  }
  .result {
    margin-top: 1.5rem;
    text-align: center;
  }
  .motoko { 
    height: 4rem; 
    margin-bottom: -5rem;
    z-index: 1000;
   } 
  .motoko img { 
    height: 100%; 
    width: auto; 
  }

.ic-badge { 
  height: 2rem; 
  } 
  .ic-badge img { 
    height: 100%; 
    width: auto; 
  }
.info-icon {
  cursor: pointer;
  transition: opacity 0.2s;
}

.info-icon:hover {
  opacity: 0.8;
}

.tooltip {
  position: absolute;
  top: calc(100% + 5px);
  left: 0;
  background: white;
  border: 1px solid #e0e0e0;
  padding: 1rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  width: 300px;
  z-index: 1000;
  font-size: 0.875rem;
  line-height: 1.5;
  color: #333;
}

.tooltip::before {
  content: '';
  position: absolute;
  top: -6px;
  left: 10px;
  width: 12px;
  height: 12px;
  background: white;
  transform: rotate(45deg);
  border-left: 1px solid #e0e0e0;
  border-top: 1px solid #e0e0e0;
}
.info-container {
  position: absolute;
  right: -2rem;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  align-items: center;
  z-index: 2;
} 
.result-container {
    flex-grow: 1;
    margin-top: 20px;
  }
  .loader-container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin: 20px 0;
}

.loader-container span {
  color: #3b00b9;
  font-size: 14px;
  font-weight: 500;
}

.loader {
  width: 24px;
  height: 24px;
  border: 3px solid rgba(59, 0, 185, 0.2);
  border-top: 3px solid #3b00b9;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { 
    transform: rotate(0deg); 
  }
  100% { 
    transform: rotate(360deg); 
  }
}

</style>