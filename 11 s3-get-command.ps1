
# Use Get-Command for finding verbs & nouns for a group of related commands

Get-Command *-S3*
Get-Command *-S3* | Select-Object * | Out-GridView


# Group on Noun, Sort Most Common First
Get-Command *-S3* |
  Group-Object -Property Noun |
    Sort-Object -Property Count -Descending

# Group on Verb, Sort Most Common First
Get-Command *-S3* |
  Group-Object -Property Verb |
    Sort-Object -Property Count -Descending

    