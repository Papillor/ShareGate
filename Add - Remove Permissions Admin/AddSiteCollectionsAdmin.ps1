# Connectez-vous au service SharePoint Online
$tenant = Connect-Tenant -Domain [namehere] -Browser

# Spécifie le chemin d'accès du fichier CSV contenant la liste des collections de sites
$csvFilePath = "[pathhere]"

# Lire les données du fichier CSV
$siteCollections = Import-Csv -Path $csvFilePath

# Boucle à travers chaque ligne du fichier CSV
foreach ($site in $siteCollections) {
    $siteCollectionURL = $site.'Site collection address'
    $siteURL = $site.'Site address'

    # Console.log pour être sûre ↓

    Write-Host "Site collection URL: $siteCollectionURL"
    Write-Host "Site URL: $siteURL"
    
    try {
        # Ajoutez-vous en tant qu'administrateur de collection de sites SharePoint
        Add-SiteCollectionAdministrator -CentralAdmin $tenant.Site -SiteUrl $siteURL

        Write-Host "Vous avez ete ajoute en tant qu'administrateur de collection de sites pour $siteCollectionURL."
    } catch {
        Write-Host "Erreur lors de l'ajout de l'administrateur au site $siteURL : $_"
    }
}
