# Regex Starter Project for Internet Computer

A starter project demonstrating how to use the regex library on the Internet Computer platform. This project serves as an example for developers looking to implement regular expressions in their Motoko applications.

## Getting Started

1. Fork this repository:

```bash
# Clone the repository
git clone https://github.com/YOUR-USERNAME/regex_starter.git
cd regex_starter
```

2. Install the regex library using mops:

```bash
mops add regex
```

3. Start a local Internet Computer replica:

```bash
dfx start --background
```

4. Deploy the project locally:

```bash
dfx deploy
```

Your application will be available at `http://localhost:4943?canisterId={asset_canister_id}`.

## Example Usage

This starter project includes examples of common regex operations such as:

- Pattern matching
- String validation
- Text extraction
- String replacement

You can find these examples in the source code and modify them to suit your needs.

## Testing the Regex Library

To test different regex patterns:

1. Start the development server:

```bash
npm start
```

2. Visit `http://localhost:3000` in your browser

3. Use the interactive interface to test various regex patterns

4. Check the console for detailed matching results

## Documentation

For more information about the regex library and Internet Computer development:

- [Regex Mops Package](https://mops.one/regex)
- [Motoko Regex Documentation](https://demali-876.github.io/motoko_regex_engine)
- [Internet Computer Developer Docs](https://internetcomputer.org/docs/current/developer-docs/)
- [Motoko Programming Language Guide](https://internetcomputer.org/docs/current/motoko/main/motoko)

## Contributing

Feel free to submit issues and enhancement requests!

- [Motoko Regex Repo](https://github.com/demali-876/motoko_regex_engine)