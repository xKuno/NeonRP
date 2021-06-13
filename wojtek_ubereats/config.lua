

Config                         = {}

Config.kosztrejestracji = 125 -- koszt rejestracji w usłudze uber eats (w menu zmieni się automatycznie)

-- Wypłaty (Serwer wylosuje kwotę pomiędzy "1" a "2" którą przyzna graczowi)

Config.Wyplata1 = 1400 -- min. wypłata za dostawę 
Config.Wyplata2 = 1500 -- max. wypłaya za dostawę 

Config.Napiwek1 = 300 -- min. napiwek
Config.Napiwek2 = 500 -- max. napiwek

-- Ustawienia losowania MISC --
Config.losuj = true

Config.wyplataNielosowa = 1 -- zmieniaj tylko jeżeli Config.losuj = false (hajs za dostawę (bez losowania))
Config.NapiwekNielosowy = 1 -- zmieniaj tylko jeżeli Config.losuj = false (napiwek za dostawę poniżej 3 minut (bez losowania))

-- Ustawienia blipa (znacznika na mapie) --

Config.typ = 233     -- rodzaj ikonki na mapie -- (dostępne rodzaje: https://wiki.gtanet.work/index.php?title=Blips)
Config.kolor = 43 --  kolor ikonki na mapie -- (dostępne kolory: https://wiki.gtanet.work/index.php?title=Blips)
Config.wielkosc = 0.7   -- wielkość ikonki (domyślnie 0.8)

Config.blipx  = 65.98     -- koordynaty (x) znacznika
Config.blipy  = -1008.51    -- koordynaty (y) znacznika


Config.pojazd = 'faggio' -- pojazd do wypożyczenia "skuter"
Config.pojazdx = 62.77 -- gdzie ma się respić pojazd (x)
Config.pojazdy = -1003.30 -- gdzie ma się respić pojazd (y)
Config.pojazdz = 28.7 -- gdzie ma się respić pojazd (z)

Config.Przebieranko = {

  MenuPodstawowe = {
    Pos   = { x = 65.98, y = -1008.51, z = 28.4 }, -- koordynaty
    Size  = { x = 2.0, y = 2.0, z = 1.0 }, -- wielkość 
    Color = { r = 0, g = 100, b = 255 }, -- kolor (RGB) 
    Type  = 25, -- typ markera
  },
}

Config.Konczeniepracy = {

  Koniecpracyboi  = {
    Pos   = { x = 68.94, y = -1008.24, z = 28.4 }, -- koordynaty
    Size  = { x = 2.0, y = 2.0, z = 1.0 }, -- wielkość 
    Color = { r = 255, g = 50, b = 50 }, -- kolor (RGB) 
    Type  = 25, -- typ markera
  },
}