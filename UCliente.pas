unit UCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Data.Win.ADODB, Vcl.ComCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Connection: TADOConnection;
    Qcliente: TADOQuery;
    dsCliente: TDataSource;
    Mcliente: TClientDataSet;
    Pcliente: TDataSetProvider;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    btNovo: TToolButton;
    btAlterar: TToolButton;
    btCancelar: TToolButton;
    btExcluir: TToolButton;
    btSalvar: TToolButton;
    btAnterior: TToolButton;
    btProximo: TToolButton;
    PCadastro: TPanel;
    DBGrid1: TDBGrid;
    MclienteIDCliente: TAutoIncField;
    Mclientenome: TStringField;
    Mclientecidade: TStringField;
    Mclienteestado: TStringField;
    Mclienteendereco: TStringField;
    Mclientenumero: TIntegerField;
    Mclientecep: TStringField;
    MclientedataNasc: TDateField;
    MclienteCPF: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBNomeCliente: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    procedure MclienteAfterPost(DataSet: TDataSet);
    procedure MclienteAfterDelete(DataSet: TDataSet);
    procedure MclienteAfterCancel(DataSet: TDataSet);
    procedure StatusBarra(ds: TDataSet);
    procedure btNovoClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAlterarClick(Sender: TObject);
    procedure btAnteriorClick(Sender: TObject);
    procedure btProximoClick(Sender: TObject);
    procedure MclienteAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btAlterarClick(Sender: TObject);
begin
  MCliente.Edit;
  StatusBarra(MCliente);
end;

procedure TForm1.btAnteriorClick(Sender: TObject);
begin
  MCliente.Prior;

end;

procedure TForm1.btCancelarClick(Sender: TObject);
begin
  MCliente.Cancel;
  StatusBarra(MCliente);
end;

procedure TForm1.btExcluirClick(Sender: TObject);
begin
   if Application.MessageBox (PChar ('Deseja excluir o arquivo?'), 'Confirmação', MB_USEGLYPHCHARS + MB_DEFBUTTON2) = mrYes  then
   begin
     MCliente.delete;
     StatusBarra(Mcliente);
   end;
end;

procedure TForm1.btNovoClick(Sender: TObject);
begin
  Mcliente.Append;
  StatusBarra(Mcliente);
  DBNomeCliente.SetFocus;

end;

procedure TForm1.btProximoClick(Sender: TObject);
begin
  MCliente.Next;
end;

procedure TForm1.btSalvarClick(Sender: TObject);
begin
  MCliente.Post;
  QCliente.Close;
  MCliente.Close;
  MCliente.Open;
  //daropen na query
  StatusBarra(MCliente);

end;

procedure TForm1.FormShow(Sender: TObject);
begin
       QCliente.Open;
       MCliente.Open;
       StatusBarra(MCliente);

end;

procedure TForm1.MclienteAfterCancel(DataSet: TDataSet);
begin
   MCliente.CancelUpdates;
end;

procedure TForm1.MclienteAfterDelete(DataSet: TDataSet);
begin
     MCliente.ApplyUpdates(-1);
end;

procedure TForm1.MclienteAfterInsert(DataSet: TDataSet);
begin
      MClientecidade.AsString := 'Curitiba';
      Mclienteestado.AsString := 'PR';
end;

procedure TForm1.MclienteAfterPost(DataSet: TDataSet);
begin
       MCliente.ApplyUpdates(-1);
end;

procedure TForm1.StatusBarra(ds: TDataSet);
begin
      btNovo.Enabled     := not(ds.State in [dsEdit, dsInsert]);
      btSalvar.Enabled   := (ds.State in [dsEdit, dsInsert]);
      btExcluir.Enabled  := not(ds.State in [dsEdit, dsInsert]) and not(ds.IsEmpty);
      btAlterar.Enabled  := not(ds.State in [dsEdit, dsInsert]) and not(ds.IsEmpty);
      btCancelar.Enabled := (ds.State in [dsEdit, dsInsert]);
      btProximo.Enabled  := not(ds.State in [dsEdit, dsInsert]) and not(ds.IsEmpty);
      btAnterior.Enabled := not(ds.State in [dsEdit, dsInsert]) and not(ds.IsEmpty);
      PCadastro.Enabled  := (ds.State in [dsEdit, dsInsert]);



end;

end.
