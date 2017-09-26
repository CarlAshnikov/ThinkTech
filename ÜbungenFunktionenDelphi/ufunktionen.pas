unit uFunktionen;

interface

uses
  Classes,
  SysUtils;

type
  TagesZeiten = (morgens, mittags, abends, nachts);
  TIntArray = array of integer;

  { TUebungen }

  TUebungen = class(TObject)
  public
    function BinIchDrin(UntereGrenze, ObereGrenze, Wert: integer): Boolean;
    function Summe1bisN(N: integer): integer;
    function murehtrhekreV(Text: string): string;
    function ZaehleDieVokale(Wort: string): integer;
    function BuchstabiereDasWort(DasWort: string): string;
    function SageDieZiffern(EineZahl: integer): string;
    function BerechneDieSumme(DieZahlen: array of integer): integer;
    function WelcheZahlFehlt(Zahlen: array of integer): integer;
    function BegruesseMich(EineTageszeit: TagesZeiten; Name: string): string;
    function Pythagokrass(A, B: double): double;
    function SagsMirSpaeter(EinText: string): string;
    function SortiereMeinArray(Zahlen: TIntArray): TIntArray;
  end;
implementation

//Aufgabe 1 Bin ich drin? Prüfe ob ein Wert im Intervall liegt.
function TUebungen.BinIchDrin(UntereGrenze, ObereGrenze, Wert: integer): Boolean;
begin
  result := false;
end;

//Aufgabe 2 Berechne die Summe aller Zahlen von 1 bis n.
function TUebungen.Summe1bisN(N: integer): integer;
begin
  result := 0;
end;

//Aufgabe 3 !murehtrhekreV: Gibt den Text rückwärts aus!
function TUebungen.murehtrhekreV(Text: string): string;
begin
  result := Text;
end;

//Aufgabe 4 Zähle alle Vokale!
function TUebungen.ZaehleDieVokale(Wort: string): integer;
begin
  result := 0;
end;

//Aufgabe 5 Buchstabiere das Wort!
function TUebungen.BuchstabiereDasWort(DasWort: string): string;
begin
  result := DasWort;
end;

//Aufgabe 6 Sage die Ziffern!
function TUebungen.SageDieZiffern(EineZahl: integer): string;
begin
  result := '';
end;

//Aufgabe 7 Berechne die Summe!
function TUebungen.BerechneDieSumme(DieZahlen: array of integer): integer;
begin
  result := 0;
end;

//Aufgabe 8 Welche Zahl in der Folge fehlt?
function TUebungen.WelcheZahlFehlt(Zahlen: array of integer): integer;
begin
  result := 0;
end;

//Aufgabe 9 Begrüße mich!
function TUebungen.BegruesseMich(EineTageszeit: TagesZeiten; Name: string): string;
begin
  result := '';
end;

//Aufgabe 10 Berechne die Hypotenuse
function TUebungen.Pythagokrass(A, B: double): double;
begin
  result := 0;
end;

//Aufgabe 11 Sag's mir später.
function TUebungen.SagsMirSpaeter(EinText: string): string;
begin
  result := EinText;
end;

//Aufgabe 12 Sortieren
function TUebungen.SortiereMeinArray(Zahlen: TIntArray): TIntArray;
begin
  result := Zahlen;
end;

end.

