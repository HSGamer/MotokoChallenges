import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Prim "mo:prim";

actor {
  public func nat_to_nat8(n: Nat) : async Nat8 {
    return Nat8.fromIntWrap(n);
  };

  public func max_number_with_n_bits(n: Nat) : async Nat {
    return Nat.pow(2, n) - 1;
  };

  public func decimal_to_bits(n: Nat) : async Text {
    var i = n;
    var bits : Text = "";
    loop {
      bits := Nat.toText(i % 2) # bits;
      i := i / 2;
    } while (i > 0);
    return bits;
  };

  public func capitalize_character(c: Char) : async Char {
    return Prim.charToUpper(c);
  };

  public func capitalize_text(t: Text) : async Text {
    var splited : Iter.Iter<Text> = Text.split(t, #char ' ');
    var capitalized : Iter.Iter<Text> = Iter.map(splited, func (s : Text) : Text {
      if (s.size() == 0) {
        return s;
      };
      let chars : [var Char] = Iter.toArrayMut(s.chars());
      chars[0] := Prim.charToUpper(chars[0]);
      for (i in Iter.range(1, chars.size() - 1)) {
        chars[i] := Prim.charToLower(chars[i]);
      };
      return Text.fromIter(chars.vals());
    });
    return Text.join(" ", capitalized);
  };

  public func is_inside(t: Text, c: Char) : async Bool {
    return Text.contains(t, #char c);
  };

  public func trim_whitespace(t: Text) : async Text {
    return Text.trim(t, #char ' ');
  };

  // TODO: implement
  public func duplicated_character(t: Text) : async Text {
    return "";
  };

  public func size_in_bytes(t: Text) : async Nat {
    return Text.encodeUtf8(t).size();
  };
};
