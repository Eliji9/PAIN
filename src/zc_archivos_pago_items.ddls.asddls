@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZC_ARCHIVOS_PAGO_ITEMS'
@ObjectModel.semanticKey: [ 'Identificador', 'Fecha', 'Sociedad', 'AccDocument' ]
define view entity ZC_ARCHIVOS_PAGO_ITEMS
  as projection on ZR_ARCHIVOS_PAGO_ITEMS
{
      @UI.lineItem: [{ position: 10, label: 'Identificador' }]
  key Identificador,
      @UI.lineItem: [{ position: 20, label: 'Fecha' }]
  key Fecha,
      @UI.lineItem: [{ position: 40, label: 'Sociedad' }]
  key Sociedad,
      @UI.lineItem: [{ position: 50, label: 'Documento de pago' }]
  key AccDocument,
      @UI.lineItem: [{ position: 60, label: 'Des. Sociedad' }]
      Companyname,

      _TotPago.Moneda                  as Waers,
      @UI.lineItem: [{ position: 70, label: 'Monto del pago' }]
      @Semantics.amount.currencyCode: 'Waers'
      _TotPago.ImportePago             as PaymentAmount,

      @UI.lineItem: [{ position: 80, label: 'Referencia' }]
      _TotPago.Referencia              as Reference,

      @UI.lineItem: [{ position: 90, label: 'Acreedor' }]
      _TotPago.Proveedor               as Supplier,

      @UI.lineItem: [{ position: 100, label: 'Nombre Acreedor' }]
      _TotPago._Supplier.SupplierName  as SupplierName,

      @UI.lineItem: [{ position: 110, label: 'Estado' }]
      estado,
      @UI.lineItem: [{ position: 120, label: 'Mensaje' }]
      Mensaje,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      Locallastchanged,

      /* Asociaciones */
      _CAB : redirected to parent ZC_ARCHIVOS_PAGO
}
