import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import List "mo:base/List";
import Char "mo:base/Char";
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

  public func duplicated_character(t: Text) : async Text {
    let reversed : [Char] = Array.reverse(Iter.toArray(t.chars()));
    var checked : Text = "";
    var result : Text = t;
    for (c in reversed.vals()) {
      if (Text.contains(checked, #char c)) {
        result := Text.fromChar(c);
      } else {
        checked := checked # Text.fromChar(c);
      };
    };
    return result;
  };

  public func size_in_bytes(t: Text) : async Nat {
    return Text.encodeUtf8(t).size();
  };

  public func bubble_sort(array : [Nat]) : async [Nat] {
    let newArray : [var Nat] = Array.thaw(array);
    let size : Nat = newArray.size();
    for (i in Iter.range(0, size - 2)) {
      for (j in Iter.range(0, size - i - 2)) {
        if (newArray[j] > newArray[j + 1]) {
          let tmp : Nat = newArray[j];
          newArray[j] := newArray[j + 1];
          newArray[j + 1] := tmp;
        };
      };
    };
    return Array.freeze(newArray);
  };

  public func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat {
    switch n {
      case (null) { m };
      case (? ni) { ni };
    };
  };

  public func day_of_the_week(n: Nat) : async ?Text {
    do ? {
      switch n {
        case (1) { "Monday" };
        case (2) { "Tuesday" };
        case (3) { "Wednesday" };
        case (4) { "Thursday" };
        case (5) { "Friday" };
        case (6) { "Saturday" };
        case (7) { "Sunday" };
        case (_) { null ! };
      };
    };
  };

  public func populate_array(array: [?Nat]) : async [Nat] {
    return Array.map<?Nat, Nat>(array, func (n: ?Nat) : Nat {
      switch n {
        case (null) { 0 };
        case (? ni) { ni };
      };
    });
  };

  public func sum_of_array(array: [Nat]) : async Nat {
    return Array.foldLeft(array, 0, func (acc : Nat, n : Nat) : Nat { acc + n });
  };

  public func squared_array(array: [Nat]) : async [Nat] {
    return Array.map(array, func (n: Nat) : Nat { n ** 2 });
  };

  public func increase_by_index(array: [Nat]) : async [Nat] {
    return Array.mapEntries(array, func (n: Nat, index: Nat) : Nat { n + index });
  };

  private func contains<A>(array: [A], a: A, f : (A, A) -> Bool) : Bool {
    return Array.foldLeft(array, false, func (result : Bool, acc : A) : Bool {
      if (f(acc, a)) {
        return true;
      } else {
        return result;
      };
    });
  };

  public func containsNum(array: [Nat], a: Nat) : async Bool {
    return contains<Nat>(array, a, func (n, m) { n == m });
  };
};
