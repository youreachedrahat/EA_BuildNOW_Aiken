fn even_odd_ifelse(x: Int) -> Bool {
  if x % 2 == 0 {
    True
  } else {
    False
  }
}

fn even_odd_whenis(x: Int) -> Bool {
  when x % 2 is {
    0 -> True
    _ -> False
  }
}

fn payment_price(payment: Int, price: Int) -> Bool {
  if payment >= price {
    True
  } else {
    False
  }
}

fn payment_price(payment: Int, price: Int) -> Bool {
  if payment >= price {
    True
  } else {
    False
  }
}

fn compare_prices_vs_payment(payment: Int, price: Int) -> Bool {
  payment >= price
}

test evenodd_ifelse_test1() {
  even_odd_ifelse(2) == True && even_odd_ifelse(3) == False
}

test evenodd_whenis_test1() {
  even_odd_whenis(2) == True && even_odd_whenis(3) == False
}

test payment_price_test_p() {
  payment_price(3, 2) == True
}

test compare_prices_vs_payment_p() {
  compare_prices_vs_payment(3, 2) == True && compare_prices_vs_payment(3, 2) == True
}
