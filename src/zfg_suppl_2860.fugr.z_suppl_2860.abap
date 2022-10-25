FUNCTION z_suppl_2860.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IT_SUPPLEMENTS) TYPE  ZTT_SUPPL_2860
*"     REFERENCE(IV_OP_TYPE) TYPE  ZDE_FLAG_2860
*"  EXPORTING
*"     REFERENCE(EV_UPDATED) TYPE  ZDE_FLAG_2860
*"----------------------------------------------------------------------
  CHECK NOT it_supplements IS INITIAL.

  CASE iv_op_type.
    WHEN 'C'. "Create
      INSERT ztb_bkngspl_2860 FROM TABLE @it_supplements.
    WHEN 'U'.
      UPDATE ztb_bkngspl_2860 FROM TABLE @it_supplements.
    WHEN 'D'.
      DELETE ztb_bkngspl_2860 FROM TABLE @it_supplements.
    WHEN OTHERS.
  ENDCASE.

  IF sy-subrc EQ 0.
    ev_updated = abap_true.
  ENDIF.

ENDFUNCTION.
