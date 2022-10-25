CLASS zcl_ext_updt_entity_2860 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ext_updt_entity_2860 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    MODIFY ENTITIES OF zi_travel_2860
           ENTITY Travel
           UPDATE FIELDS ( agency_id description )
           WITH VALUE #( ( travel_id   = '00000001'
                           agency_id   = '070017'
                           description = 'External Update 2860'
           ) )
           FAILED DATA(failed)
           REPORTED DATA(reported).

    READ ENTITIES OF zi_travel_2860
    ENTITY Travel
    FIELDS ( agency_id description  )
    WITH VALUE #( ( travel_id = '00000001' ) )
    RESULT DATA(lt_travel_data)
    FAILED failed
    REPORTED reported.

    COMMIT ENTITIES.
    IF failed IS INITIAL.
      out->write( 'Commit Successful' ).
    ELSE.
      out->write( 'Commit Failed' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
