#Requires -Version 7.0
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root 'modules/experimental/trades'
$destination = Join-Path $root 'dist/iota_trading_test_mc1.21.11.zip'

foreach ($generator in @('build-trading-catalog.mjs', 'build-trading-production-pools.mjs', 'trading-explorer-maps.mjs')) {
  & node (Join-Path $PSScriptRoot $generator)
  if ($LASTEXITCODE -ne 0) { throw "Failed to run $generator" }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
$temporary = Join-Path (Split-Path -Parent $destination) ('.trading-test-' + [guid]::NewGuid().ToString('N') + '.zip')
$archive = [IO.Compression.ZipFile]::Open($temporary, [IO.Compression.ZipArchiveMode]::Create)
function Add-TextEntry($path, $content) {
  $entry = $archive.CreateEntry($path, [IO.Compression.CompressionLevel]::Optimal)
  $writer = [IO.StreamWriter]::new($entry.Open(), [Text.UTF8Encoding]::new($false))
  try { $writer.Write($content) } finally { $writer.Dispose() }
}

try {
  Add-TextEntry 'pack.mcmeta' '{"pack":{"description":"Iota Trading - Java 1.21.11 test","min_format":[94,1],"max_format":[94,1]}}'
  $readme = @'
Iota Trading test for Minecraft Java 1.21.11

Install this ZIP in the datapacks folder of a disposable world. Do not enable the experimental Villager Trade Rebalance for this test.

With commands enabled, use /function iota_trades:production/test_spawn
This creates a new test villager. Give it the workstation for the profession you want to try, and step away from its interaction area briefly so the initial offers can publish. Existing and untagged villagers keep their vanilla or previously saved data.

The test covers runtime draws for the 13 approved professions. Regional trade is deferred. Current prices and restock timing are provisional. Cartographer structure searches may still delay a tick, especially in unexplored terrain.
'@
  Add-TextEntry 'README.txt' $readme
  foreach ($file in Get-ChildItem -LiteralPath (Join-Path $source 'data') -File -Recurse) {
    $entryPath = [IO.Path]::GetRelativePath($source, $file.FullName).Replace('\', '/')
    if ($entryPath -match '^data/iota_trades/(function/catalog/(?:templates|current_templates|classify|classify_at)\.mcfunction|tags/worldgen/biome/regions/)') {
      continue
    }
    if ($entryPath -eq 'data/iota_trades/function/load.mcfunction') {
      $content = [IO.File]::ReadAllText($file.FullName)
      $content = [regex]::Replace($content, '(?m)^function iota_trades:catalog/(?:templates|current_templates)\r?\n', '')
      Add-TextEntry $entryPath ($content + "scoreboard players set #new_only it_identity_tmp 1`n")
    } elseif ($entryPath -eq 'data/iota_trades/function/catalog/init.mcfunction') {
      $content = [IO.File]::ReadAllText($file.FullName)
      $production = 'execute if entity @s[tag=iota_trades_production_test] run return run function iota_trades:production/start'
      $offset = $content.IndexOf($production, [StringComparison]::Ordinal)
      if ($offset -lt 0) { throw 'Production entry point missing' }
      Add-TextEntry $entryPath ($content.Substring(0, $offset + $production.Length) + "`n")
    } else {
      [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($archive, $file.FullName, $entryPath) | Out-Null
    }
  }
} finally {
  $archive.Dispose()
}
Move-Item -LiteralPath $temporary -Destination $destination -Force
Write-Output $destination
