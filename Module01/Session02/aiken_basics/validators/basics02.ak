// Its good practice to be explicit about your types

// We can use variables and other functions inside functions
fn main(x: Int, y: Int) -> Int {
    let z = sum(x, y)
    x + y + z
}

fn sum(x: Int, y: Int) -> Int {
    x + y
}


//Practice 001 - Create the substraction (-) function and test it 
//Practice 002 - Create the multiplication (*) function and test it 
//Practice 003 - Create the division (/) function and test it
//Practice 004 - Modify the main function that uses the sum function and the new functions created in the previous practices and test it


test sum_test() {
    sum(5, 6) == 11
}
test main_test() {
    main(5, 6) == 22
}