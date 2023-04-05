object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 414
  Width = 522
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 16
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    Left = 40
    Top = 80
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=db_wk_teste'
      'User_Name=postgres'
      'Password=sysdba'
      'DriverID=PG')
    LoginPrompt = False
    Left = 136
    Top = 16
  end
  object FDQueryPessoa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from pessoa')
    Left = 176
    Top = 104
  end
  object FDQueryEndereco: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from endereco')
    Left = 176
    Top = 160
  end
  object DataSetProviderPessoa: TDataSetProvider
    DataSet = FDQueryPessoa
    Left = 312
    Top = 104
  end
  object DataSetProviderEndereco: TDataSetProvider
    DataSet = FDQueryEndereco
    Left = 312
    Top = 160
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection
    Left = 240
    Top = 24
  end
end
