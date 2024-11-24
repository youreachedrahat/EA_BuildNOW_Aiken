fn basic01() {
  True && False && True || False
}

test basic() {
  let num = 100_000
  basic01() == False
}
