function Publish-ChefPkg($publishSettingsFile, $subscriptionName, $publishUri, $definitionXmlFile, $postOrPut) {
  trap [Exception] {echo $_.Exception.Message;exit 1}

  write-host "Publish-ChefPkg called with: $publishSettingsFile, `'$subscriptionName`', $publishUri, $definitionXmlFile, $postOrPut"

  Import-AzurePublishSettingsFile -PublishSettingsFile $publishSettingsFile

  $subscription = Get-AzureSubscription -SubscriptionName $subscriptionName

  $bodyxml = Get-Content $definitionXmlFile

  # Trigger the publish
  Invoke-RestMethod -Method $postOrPut -Uri $publishUri -Certificate $subscription.Certificate -Headers @{'x-ms-version'='2014-04-01'} -Body $bodyxml -ContentType application/xml;
}

Export-ModuleMember -Function Publish-ChefPkg