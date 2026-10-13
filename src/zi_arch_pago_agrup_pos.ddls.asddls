@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total pago por factura (propuesta de pago)'
/*
  Una fila por factura (AccountingDocument) dentro de una ejecución del
  programa de pagos. Agrega las N posiciones de I_PaymentProposalItem
  (REGUP) para evitar la multiplicación de filas en ZR_ARCHIVOS_PAGO_ITEMS.

  Campos marcados con
  Valídalos con F2 sobre I_PaymentProposalItem antes de activar.
*/
define view entity ZI_ARCH_PAGO_AGRUP_POS
  as select from I_PaymentProposalItem

  association [0..1] to I_Supplier as _Supplier
    on $projection.Proveedor = _Supplier.Supplier
{
  key PaymentRunDate                as Fecha,
  key PaymentRunID                  as Identificador,
  key CompanyCode                   as Sociedad,
  key AccountingDocument            as AccDocument,
  key FiscalYear                    as Ejercicio,
      PaymentDocument               as DocumentoPago,
      Supplier                      as Proveedor,
      DocumentReferenceID           as Referencia,
      PaymentCurrency               as Moneda,

      @Semantics.amount.currencyCode: 'Moneda'
      sum( case DebitCreditCode
             when 'H' then NetAmountInTransacCurrency
             else NetAmountInTransacCurrency * -1
           end )                    as ImportePago,

      count( * )                    as CantPosiciones,

      _Supplier
}
where
  PaymentRunIsProposal = ''
group by
  PaymentRunDate,
  PaymentRunID,
  CompanyCode,
  AccountingDocument,
  FiscalYear,
  PaymentDocument,
  Supplier,
  DocumentReferenceID,
  PaymentCurrency
