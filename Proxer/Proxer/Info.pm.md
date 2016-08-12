# Name

Proxer::Info

# Functions

## GetEntry

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Get_Entry)

Get the main information about an anime or manga.

    $anime = GetEntry($id);

Returns:

    $VAR1 = {
        'name' => 'One Piece',
        'state' => '2',
        'clicks' => '22858',
        'genre' => 'Abenteuer Action Comedy Drama Fantasy Martial-Art Mystery Shounen Superpower Violence',
        'fsk' => 'fsk12 bad_language violence',
        'rate_sum' => '82413',
        'rate_count' => '8851',
        'medium' => 'animeseries',
        'count' => '800',
        'description' => "Wir schreiben [...] der Piraten!\n(Quelle: Kaz\x{e9})",
        'license' => '2',
        'id' => '53',
        'kat' => 'anime'
    };

## GetNames

Todo... 

    $prxrinfo->GetNames($id);

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Names)

## GetGate

Todo...

    $prxrinfo->GetGate($id);

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Gate)

## GetLang

Todo...

    $prxrinfo->GetLang($id);

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Lang)

## GetSeason

Todo...

    $prxrinfo->GetSeason($id);

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Season)

## GetGroups

Todo...

    $prxrinfo->GetGroups($id);

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Groups)

## GetListinfo

    $prxrinfo->GetListinfo($id, $page, $limit);

More at [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Listinfo)