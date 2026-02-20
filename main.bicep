param containerName string = 'ghcontainer'

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: containerName
  location: location
  properties: {
    osType: 'Linux'
    containers: [
      {
        name: 'app'
        properties: {
          image: 'mcr.microsoft.com/azuredocs/aci-helloworld'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 1.5
            }
          }
          ports: [
            {
              port: 80
            }
          ]
          environmentVariables: [
            {
              name: 'ENV'
              value: 'AZ104'
            }
          ]
        }
      }
    ]
    ipAddress: {
      type: 'Public'
      ports: [
        {
          protocol: 'TCP'
          port: 80
        }
      ]
    }
  }
}

output fqdn string = containerGroup.properties.ipAddress.fqdn
