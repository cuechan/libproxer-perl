# Name

Proxer::Info

# Functions

## GetEntry

View \[Proxer Wiki\](http://proxer.me/wiki/Proxer\_API/v1/Info#Get\_Entry)

Get the main information about an anime or manga.

    $anime = GetEntry($id);

Returns:
    $VAR1 = {
        'name' => 'One Piece',
        'state' => '2',
        'clicks' => '22858',
        'genre' => 'Abenteuer Action Comedy Drama Fantasy Martial-Art Mystery Shounen Superpower Violence',
        'fsk' => 'fsk12 bad\_language violence',
        'rate\_sum' => '82413',
        'rate\_count' => '8851',
        'medium' => 'animeseries',
        'count' => '800',
        'description' => "Wir schreiben \[...\] der Piraten!\\n(Quelle: Kaz\\x{e9})",
        'license' => '2',
        'id' => '53',
        'kat' => 'anime'
    };
