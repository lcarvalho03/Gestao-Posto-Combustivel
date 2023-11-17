unit UViewRptAbastecimentoDiaTanqueBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.StdCtrls, Data.DB, Data.Win.ADODB, UDM, Vcl.Grids, Vcl.DBGrids, RLReport,
  Datasnap.DBClient, Datasnap.Provider;

type
  TFrmRptAbastecimentoDiaTanqueBomba = class(TForm)
    Panel1: TPanel;
    btnFechar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    dtpInicio: TDateTimePicker;
    dtpTermino: TDateTimePicker;
    Label3: TLabel;
    DataSource: TDataSource;
    ADOQuery: TADOQuery;
    DBGrid1: TDBGrid;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLGroupDataAbastecimento: TRLGroup;
    RLDBText6: TRLDBText;
    RLGroupTanqueCombustivel: TRLGroup;
    RLGroupBombaCombustivel: TRLGroup;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLSystemInfo4: TRLSystemInfo;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    DataSetProvider1: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    cdsConsultaid: TAutoIncField;
    cdsConsultadata_abastecimento: TDateTimeField;
    cdsConsultatanque_combustivel: TStringField;
    cdsConsultabomba_combustivel: TStringField;
    cdsConsultatipo_combustivel: TStringField;
    cdsConsultavalor_litro: TBCDField;
    cdsConsultaqtd_litro_combustivel: TBCDField;
    cdsConsultapercentual_imposto: TBCDField;
    cdsConsultavalor_total: TFMTBCDField;
    cdsConsultavalor_imposto: TFMTBCDField;
    rlblDtInicio: TRLLabel;
    RLLabel6: TRLLabel;
    rlblDtTermino: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    btnImprimir: TSpeedButton;
    btnConsulta: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRptAbastecimentoDiaTanqueBomba: TFrmRptAbastecimentoDiaTanqueBomba;

implementation

uses
  System.SysUtils;


{$R *.dfm}

procedure TFrmRptAbastecimentoDiaTanqueBomba.btnImprimirClick(Sender: TObject);
begin
  rlblDtInicio.Caption := FormatDateTime('dd/MM/yyyy', dtpInicio.Date);
  rlblDtTermino.Caption := FormatDateTime('dd/MM/yyyy', dtpTermino.Date);
  RLReport1.Preview();
end;

procedure TFrmRptAbastecimentoDiaTanqueBomba.btnConsultaClick(Sender: TObject);
begin
  ADOQuery.Close;
  ADOQuery.Parameters.ParamByName('dt_inicio').Value := dtpInicio.Date;
  ADOQuery.Parameters.ParamByName('dt_termino').Value := dtpTermino.Date;
  ADOQuery.Open;

  cdsConsulta.Close;
  cdsConsulta.ParamByName('dt_inicio').Value := dtpInicio.Date;
  cdsConsulta.ParamByName('dt_termino').Value := dtpTermino.Date;
  cdsConsulta.Open;

  cdsConsulta.First;
  btnImprimir.Enabled := (not cdsConsulta.IsEmpty);

  {
  if (not cdsConsulta.IsEmpty) then
  begin
    rlblDtInicio.Caption := FormatDateTime('dd/MM/yyyy', dtpInicio.Date);
    rlblDtTermino.Caption := FormatDateTime('dd/MM/yyyy', dtpTermino.Date);
    RLReport1.Preview();
  end;
  }
end;

procedure TFrmRptAbastecimentoDiaTanqueBomba.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
