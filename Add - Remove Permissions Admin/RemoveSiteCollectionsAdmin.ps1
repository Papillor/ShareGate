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
        # Supprimez-vous en tant qu'administrateur de collection de sites SharePoint
        Remove-SiteCollectionAdministrator -CentralAdmin $tenant.Site -SiteUrl $siteURL

        Write-Host "Vous avez ete supprime en tant qu'administrateur de collection de sites pour $siteCollectionURL."
    } catch {
        Write-Host "Erreur lors de la suppression de l'administrateur du site $siteURL : $_"
    }
}
