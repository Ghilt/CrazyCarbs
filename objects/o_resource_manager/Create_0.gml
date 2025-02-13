enum Resource
{
    LUMBER,
    WOOL,
    GOLD
};

// Indexes tied to enum above
resources = [0, 0, 0]

resourceInstances = []


function generateResource(type, amount, visualInstance) {
    resources[type] += amount
    array_push(resourceInstances, visualInstance)
}