unit uFunktionen;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils;

type
  TagesZeiten = (morgens, mittags, abends, nachts);

implementation

//Aufgabe 1 Bin ich schon drin? Prüfe ob ein Wert im Intervall liegt.
function BinIchDrin(ObereGrenze, UntereGrenze, Wert: integer): Boolean;
begin
  result := false;
end;

//Aufgabe 2 Berechne die Summe aller Zahlen von 1 bis n.
function Summe1bisN(N: integer): integer;
begin
  result := 0;
end;

//Aufgabe 3 !murehtrhekreV: Gibt den Text rückwärts aus!
function murehtrhekreV(Text: string): string;
begin
  result := Text;
end;

//Aufgabe 4 Zähle alle Vokale!
function ZaehleDieVokale(Wort: string): integer;
begin
  result := 0;
end;

//Aufgabe 5 Buchstabiere das Wort!
function BuchstabiereDasWort(DasWort: string): string;
begin
  result := DasWort;
end;

//Aufgabe 6 Sage die Ziffern!
function SageDieZiffern(EineZahl: integer): string;
begin
  result := '';
end;

//Aufgabe 7 Berechne die Summe!
function BerechneDieSumme(DieZahlen: string): integer;
begin
  result := 0;
end;

//Aufgabe 8 Welche Zahl in der Folge fehlt?
function WelcheZahlFehlt(Zahlen: array of integer): integer;
begin
  result := 0;
end;

//Aufgabe 9 Begrüße mich!
function BegruesseMich(EineTageszeit: TagesZeiten; Name: string): string;
begin
  result := '';
end;

//Aufgabe 10 Pythagokrass: Berechne die Hypotenuse
function Pythagokrass(A, B: double): double;
begin
  result := 0;
end;

//Aufgabe 11 Sag's mir später.
function SagsMirSpaeter(EinText: string): string;
begin
  result := EinText;
end;

end.

