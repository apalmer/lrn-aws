$awsServices = Get-Content "$PSScriptRoot\Technology\index.yaml" | ConvertFrom-Yaml
$rootName = 'AWS Services and Features'
$flashcard = @{ Answer = {}}

function Get-Technology {
    param(
        $categoryName
    )
    
    if($categoryName){
        $category = $awsServices[$rootName][$categoryName]
        $randomized = Random-Access $category
    }
    else {
        $all = $awsServices[$rootName].GetEnumerator() | Where-Object{ $_.Value }| ForEach-Object{ $_.Value.GetEnumerator() }
        $randomized = $all | Get-Random
    }

    $card = New-Flashcard $randomized
    $flashcard.Answer = $card.Answer

    $card.Question
}

function Get-Answer {
    $flashcard.Answer
}

function New-Flashcard {
    param($flashcard)
    if ( 0,1 | Get-Random){
        Get-Description $flashcard
    }
    else {
        Get-Name $flashcard
    }
}

function Get-Description {
    param($flashcard)
    @{ Question=$flashcard.Key; Answer=$flashcard.Value;}
}

function Get-Name {
    param($flashcard)
    @{ Question=$flashcard.Value['description']; Answer=$flashcard.Key;}
}

function Random-Category {
    Random-Access $awsServices[$rootName]
}

function Random-Access{
    param( 
        $hash
    )

    $h = $hash.GetEnumerator()
    $h | Get-Random
}