@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transacciones'
define view entity ZR_ARCHIVOS_PAGO_ITEMS
  as select from zarch_pain_det as detalle

  association to parent ZR_ARCHIVOS_PAGO as _CAB
    on  $projection.Identificador = _CAB.Identificador
    and $projection.Fecha         = _CAB.Fecha
    and ' '                      <> _CAB.Referencia
    and $projection.Sociedad      = _CAB.Sociedad

  association [0..1] to I_CompanyCode as _CompanyCode
    on $projection.Sociedad = _CompanyCode.CompanyCode

  // Reemplaza _Regup (regup) y _Regu (I_PaymentProposalItem):
  // una sola fila por factura, con el importe ya sumado.
  association [0..1] to ZI_ARCH_PAGO_AGRUP_POS as _TotPago
    on  $projection.Fecha         = _TotPago.Fecha
    and $projection.Identificador = _TotPago.Identificador
    and $projection.Sociedad      = _TotPago.Sociedad
    and $projection.AccDocument   = _TotPago.AccDocument
    and $projection.Ejercicio     = _TotPago.Ejercicio
{
  key cast( identificador as farp_laufi preserving type )   as Identificador,
  key fecha                                                 as Fecha,
  key cast( sociedad as farp_dzbukr preserving type )       as Sociedad,
  key cast( substring( documento_pago, 5, 10 )
            as farp_vblnr preserving type )                 as AccDocument,

      // documento_pago = BUKRS(4) + BELNR(10) + GJAHR(4)
      cast( substring( documento_pago, 15, 4 ) as gjahr )   as Ejercicio,

      // ------------------------------------------------------------------
      // >>> CONSERVAR AQUÍ los campos de tu versión actual (línea 31 en
      // >>> adelante): Companyname, estado, Mensaje, Createdby, Createdat,
      // >>> Lastchangedby, Lastchangedat, Locallastchanged, etc.
      // >>> Esta parte no se ve en las capturas, por eso no se reescribió.
      // ------------------------------------------------------------------

      /* Asociaciones expuestas
         (quitar _Regup y _Regu de la versión actual) */
      _CAB,
      _CompanyCode,
      _TotPago
}
