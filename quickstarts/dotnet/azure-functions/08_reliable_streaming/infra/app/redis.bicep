@description('Name of the Redis Cache')
param name string

@description('Location for the Redis Cache')
param location string

@description('Tags for the Redis Cache')
param tags object = {}

@description('SKU name for Redis Cache (Basic, Standard, Premium)')
param skuName string = 'Basic'

@description('Capacity for Redis Cache (0-6 for Basic/Standard, 1-4 for Premium)')
param capacity int = 0

resource redisCache 'Microsoft.Cache/redis@2024-03-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: skuName
      family: skuName == 'Premium' ? 'P' : 'C'
      capacity: capacity
    }
    redisVersion: '6'
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    enableNonSslPort: false
  }
}

output hostName string = redisCache.properties.hostName
output sslPort int = redisCache.properties.sslPort
output name string = redisCache.name
output primaryKey string = redisCache.listKeys().primaryKey
