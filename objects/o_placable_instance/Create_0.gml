enum Carry {
    None, ClickCarry, HoldCarry
}

carry = Carry.None
smoothCarry = 0.4
smoothScale = 0.4
clickGuard = false
time = 0
threshold = 5