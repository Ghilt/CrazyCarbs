if (carry == Carry.ClickCarry || carry == Carry.HoldCarry) {
    rotationModifier *= -1  
    footprint = rotationModifier == 1 ? carriedBuildingData.footprint : carriedBuildingData.getRotatedFootprint()
      
}
