use aiken/collection/list
use aiken/option
use aiken/primitive/bytearray
use aiken/primitive/int

// Prime Number Activity ================================================================
fn prime_number(n: Int, i: Int) -> Bool {
  if i * i > n {
    True
  } else if n % i == 0 {
    False
  } else {
    prime_number(n, i + 1)
  }
}

fn check_prime(n: Int) -> Bool {
  if n <= 1 {
    False
  } else {
    prime_number(n, 2)
  }
}

test prime_test() {
  check_prime(9) == False
}

// Fibonacci Activity ================================================================
fn fibonacci(n: Int) -> Int {
  if n == 0 {
    0
  } else if n == 1 {
    1
  } else {
    fibonacci(n - 2) + fibonacci(n - 1)
  }
}

test fibonacci_test() {
  fibonacci(3) == 2
}

// Empty String Activity ================================================================
fn list_empty(list: List<a>) -> Bool {
  list == []
}

test emptylist_test() {
  list_empty([]) == True && list_empty([1, 4]) == False
}

// palindrome check ================================================================

// at(self: ByteArray, index: Int) -> Byte
// bytearray.length(#[1, 2, 3]) == 3
// bytearray.slice(#[0, 1, 2, 3, 4, 5, 6], start: 1, end: 3) == #[1, 2, 3]

fn palindrome(input: ByteArray) -> Bool {
  let len = bytearray.length(input)
  if bytearray.length(input) <= 1 {
    True
  } else if bytearray.at(input, 0) == bytearray.at(input, len - 1) {
    palindrome(bytearray.slice(input, start: 1, end: len - 2))
  } else {
    False
  }
}

test palindrome_test() {
  palindrome("rahar") == True && palindrome("rahat") == False
}

// max num check ================================================================
// list.drop([1, 2, 3], 2)
// list.unique([1, 2, 3, 1]) == [1, 2, 3]
// at(self: List<a>, index: Int) -> Option<a>
// list.take([1, 2, 3], 2) == [1, 2]

fn max_num(list: List<Int>, max: Int) -> Int {
  let i = option.or_else(list.head(list), 0)
  if list == [] {
    max
  } else if i >= max {
    let max = i
    max_num(list.drop(list, 1), max)
  } else {
    max
  }
}

fn max_num_n(list: List<Int>) -> Option<Int> {
  let len = list.length(list)
  list.at(list.sort(list, int.compare), len - 1)
}

fn max_num_when(list: List<Int>, max: Int) -> Int {
  let i =
    when list.head(list) is {
      Some(a) -> a
      None -> 0
    }
  if list == [] {
    0
  } else if i >= max {
    let max = i
    max_num(list.drop(list, 1), max)
  } else {
    max
  }
}

test max_test() {
  max_num([2, 4, 6, 7, 8, 9, 3, 2], 0) == 9
}

test maxwhen_test() {
  max_num_when([2, 4, 6, 7, 8, 9, 3, 2], 0) == 9
}

test maxn_test() {
  max_num_n([2, 4, 6, 7, 8, 9, 3, 2]) == Some(9)
}

// vowel exist check ================================================================
// first element check vowel 
// drop first element and recall
// empty list return False

const vowel_list = "aeiouAEIOU"

fn vowel(string: ByteArray) -> Bool {
  when bytearray.is_empty(string) is {
    True -> False
    False ->
      if bytearray.index_of(vowel_list, bytearray.take(string, 0)) == None {
        vowel(bytearray.drop(string, 1))
      } else {
        True
      }
  }
}

test vowel_check() {
  vowel("faizan") == True
}

fn count_vowel(string: ByteArray, n: Int) -> Int {
  when bytearray.is_empty(string) is {
    True -> n
    False ->
      if bytearray.index_of(vowel_list, bytearray.take(string, 1)) == None {
        count_vowel(bytearray.drop(string, 1), n)
      } else {
        count_vowel(bytearray.drop(string, 1), n + 1)
      }
  }
}

fn count_v(string: ByteArray) -> Int {
  count_vowel(string, 0)
}

test count_vowel_check() {
  count_v("faizan") == 3
}

//===================================================
fn count_vowels3(x: ByteArray) -> Int {
  let vowels = "aeiouAEIOU"
  bytearray.foldl(
    x,
    0,
    fn(byte, acc) {
      if bytearray.index_of(vowels, bytearray.from_int_big_endian(byte, 1)) != None {
        acc + 1
      } else {
        acc
      }
    },
  )
}

test count_vowels_test3() {
  count_vowels3("faizan") == 3
}
