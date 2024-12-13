import Regex "mo:regex";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
actor {
  public func match(pattern : Text, flags : ?Regex.Flags, string : Text) : async Text {
    let regex = Regex.Regex(pattern, flags);

    switch (regex.match(string)) {
      case (#ok(match)) {
        matchToText(match)
      };
      case (#err(err)) {
        debug_show (err)
      }
    }
  };

  
  public func search(pattern : Text, flags : ?Regex.Flags, string : Text) : async Text {
    let regex = Regex.Regex(pattern, flags);
    switch (regex.search(string)) {
      case (#ok(match)) {matchToText(match)};
      case (#err(err)) {debug_show (err)}
    }
  };

  
public func findAll(pattern : Text, flags : ?Regex.Flags, string : Text) : async Text {
    let regex = Regex.Regex(pattern, flags);
    switch (regex.findAll(string)) {
      case (#ok(matches)) {
        if (matches.size() == 0) {
          "No matches found"
        } else {
          var results = "Found " # Int.toText(matches.size()) # " matches:\n";
          for (i in matches.keys()) {
            results #= "\n=== Match " # Int.toText(i + 1) # " ===\n" #
            matchToText(matches[i])
          };
          results
        }
      };
      case (#err(err)) {
        debug_show (err)
      }
    }
  };

  func matchToText(match : Regex.Match) : Text {
    let statusText = switch (match.status) {
      case (#FullMatch) {"Full Match"};
      case (#NoMatch) {"No Match"}
    };
    let groupsText = switch (match.capturedGroups) {
      case (null) {"No captured groups"};
      case (?groups) {
        if (groups.size() == 0) {
          "No captured groups"
        } else {
          var text = "Captured Groups:\n";
          for (group in groups.vals()) {
            text #= "  Group '" # group.0 # "' at position " # Nat.toText(group.1) # "\n"
          };
          text
        }
      }
    };

    var spansText = if (match.spans.size() == 0) {
      "No spans"
    } else {
      var text = "Spans:\n";
      for (span in match.spans.vals()) {
        text #= "  (" # Nat.toText(span.0) # ", " # Nat.toText(span.1) # ")\n"
      };
      text
    };

    "Match Result:\n" #
    "Status: " # statusText # "\n" #
    "Position: (" # Nat.toText(match.position.0) # ", " # Nat.toText(match.position.1) # ")\n" #
    "Value: " # match.value # "\n" #
    groupsText # "\n" #
    spansText #
    "Last Index: " # Nat.toText(match.lastIndex)
  }
}
