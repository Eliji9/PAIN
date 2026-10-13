# PAIN – Archivos de pago (RAP / DS4)

Ajuste para evitar filas repetidas en los ítems de `ZC_ARCHIVOS_PAGO_ITEMS`.

## Problema

`ZR_ARCHIVOS_PAGO_ITEMS` tenía dos asociaciones declaradas `[0..1]` hacia las
posiciones de la propuesta de pago (`regup` y `I_PaymentProposalItem`). En la
práctica hay **N posiciones por factura**, y la ZC tomaba campos de ambas, por lo
que el resultado salía N × N (16 filas para una factura con 4 posiciones).

## Solución

Una vista intermedia agregada por factura, construida sobre la vista estándar
liberada `I_PaymentProposalItem` (sin acceso directo a REGUP):

| Objeto | Cambio |
|---|---|
| `ZI_ARCH_PAGO_AGRUP_POS` | **Nuevo.** Una fila por factura con `sum()` del importe |
| `ZR_ARCHIVOS_PAGO_ITEMS` | Quita `_Regup` / `_Regu`, agrega `_TotPago` (sin condición por ejercicio) |
| `ZC_ARCHIVOS_PAGO_ITEMS` | Lee moneda, monto, referencia y acreedor desde `_TotPago`; quita `_base` |

## Antes de activar

1. `ZI_ARCH_PAGO_AGRUP_POS` ya está activa en DS4.
2. En `ZR_ARCHIVOS_PAGO_ITEMS`, conserva tus campos desde la línea 31 donde
   indica el comentario `>>> CONSERVAR AQUÍ`.

Orden de activación: **ZI → ZR → ZC**.
