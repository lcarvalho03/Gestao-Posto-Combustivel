unit ULib;

interface

uses
  Data.Win.ADODB, Vcl.Forms, Vcl.StdCtrls, System.Generics.Collections,
  UModelTipoCombustivel, UModelTanqueCombustivel, UModelBombaCombustivel;

function ObtemComponenteQuery(sql_command: WideString): TADOQuery;
function ObtemDoubleFromString(texto: string): Double;
procedure ControlarEdicaoComponentesForm(form: TForm; tag: Integer);
procedure LimpaObjetosDoCombobox(combobox: TCombobox);
procedure MontaComboboxTipoCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TTipoCombustivel>);
procedure MontaComboboxTanqueCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TTanqueCombustivel>);
procedure MontaComboboxBombaCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TBombaCombustivel>);

implementation

uses
  UDM, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBGrids, System.SysUtils;

function ObtemComponenteQuery(sql_command: WideString): TADOQuery;
var
  lQuery: TADOQuery;
begin
  lQuery := TADOQuery.Create(nil);
  lQuery.Connection := DM.ADOCOnnection;
  lQuery.Close;
  lQuery.SQL.Clear;
  lQuery.SQL.Add(sql_command);
  Result := lQuery;
end;

function ObtemDoubleFromString(texto: string): Double;
begin
  texto := StringReplace(texto, '.', '', [rfReplaceAll, rfIgnoreCase]);
  //texto := StringReplace(texto, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  Result := StrToFloat(texto);
end;

procedure ControlarEdicaoComponentesForm(form: TForm; tag: Integer);
var
  lEnable: Boolean;
  i: Integer;
begin
  if tag = 1 then
    lEnable := False
  else
    lEnable := True;

  for i := form.ComponentCount -1 downto 0 do
  begin
    if (form.Components[i] is TSpeedButton) then
    begin
      if (form.Components[i].tag = 1) then
        TSpeedButton(form.Components[i]).Enabled := lEnable
      else
        TSpeedButton(form.Components[i]).Enabled := (not lEnable);
    end
    else if (form.Components[i] is TPanel) and (TPanel(form.Components[i]).tag = 1) then
    begin
      if (tag = 2) then
        TPanel(form.Components[i]).Enabled := False
      else
        TPanel(form.Components[i]).Enabled := True;
    end
    else if (form.Components[i] is TDBGrid) then
      TDBGrid(form.Components[i]).Enabled := lEnable;
  end;
end;

procedure LimpaObjetosDoCombobox(combobox: TCombobox);
var
  i: Integer;
begin
  for I := (combobox.Items.Count - 1) downto 0 do
    TObject(combobox.Items.Objects[i]).Free;

  combobox.Items.Clear;
end;

procedure MontaComboboxTipoCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TTipoCombustivel>);
var
  i: Integer;
begin
  LimpaObjetosDoCombobox(combobox);

  for I := 0 to (listaDeObjetos.Count - 1) do
    combobox.Items.AddObject(TTipoCombustivel(listaDeObjetos.Items[i]).nome, TTipoCombustivel(listaDeObjetos.Items[i]));
end;

procedure MontaComboboxTanqueCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TTanqueCombustivel>);
var
  i: Integer;
begin
  LimpaObjetosDoCombobox(combobox);

  for I := 0 to (listaDeObjetos.Count - 1) do
    combobox.Items.AddObject(TTanqueCombustivel(listaDeObjetos.Items[i]).nome, TTanqueCombustivel(listaDeObjetos.Items[i]));
end;

procedure MontaComboboxBombaCombustivel(combobox: TComboBox; listaDeObjetos: TObjectList<TBombaCombustivel>);
var
  i: Integer;
begin
  LimpaObjetosDoCombobox(combobox);

  for I := 0 to (listaDeObjetos.Count - 1) do
    combobox.Items.AddObject(TBombaCombustivel(listaDeObjetos.Items[i]).nome, TBombaCombustivel(listaDeObjetos.Items[i]));
end;

end.
