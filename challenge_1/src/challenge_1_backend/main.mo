import List "mo:base/List";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public func add(a : Nat, b : Nat) : async Nat {
    return a + b;
  };

  public func square(n : Nat) : async Nat {
    return n * n;
  };

  public func days_to_seconds(days : Nat) : async Nat {
    return days * 24 * 60 * 60;
  };

  var count : Nat = 0;
  public func increment_counter() : async Nat {
    count := count + 1;
    return count;
  };

  public func clear_counter() : async Nat {
    count := 0;
    return count;
  };

  public func divide(n : Nat, m : Nat) : async Bool {
    return n % m == 0;
  };

  public func is_even(n : Nat) : async Bool {
    return await divide(n, 2);
  };

  public func sum_of_array(array : [Nat]) : async Nat {
    var sum : Nat = 0;
    for (i in array.vals()) {
      sum := sum + i;
    };
    return sum;
  };

  public func maximum(array : [Nat]) : async Nat {
    var max : Nat = 0;
    for (i in array.vals()) {
      if (i > max) {
        max := i;
      };
    };
    return max;
  };

  public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
    var list : List.List<Nat> = List.fromArray(array);
    var filtered : List.List<Nat> = List.filter<Nat>(list, func (val) { val != n });
    return List.toArray(filtered);
  };

  private func swap(array : [var Nat], i : Nat, j : Nat) : () {
    var temp : Nat = array[i];
    array[i] := array[j];
    array[j] := temp;
  };

  public func selection_sort(array : [Nat]) : async [Nat] {
    let newArray : [var Nat] = Array.thaw(array);
    let size : Nat = newArray.size();
    var index : Nat = 0;
    while (index < size) {
      var maxIndex : Nat = index;
      for (i in Iter.range(index + 1, size - 1)) {
        if (newArray[i] < newArray[maxIndex]) {
          maxIndex := i;
        };
      };
      if (maxIndex != index) {
        swap(newArray, index, maxIndex);
      };
      index := index + 1;
    };
    return Array.freeze(newArray);
  };
};
