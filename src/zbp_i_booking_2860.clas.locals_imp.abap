CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalFlightPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalFlightPrice.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~validateStatus.

    METHODS get_instance_features FOR FEATURES IMPORTING keys REQUEST requested_features FOR booking RESULT result.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateTotalFlightPrice.

    IF NOT keys IS INITIAL.
      zcl_aux_travel_det_2860=>calculate_price( it_travel_id =
      VALUE #( FOR GROUPS <booking> OF booking_key IN keys
      GROUP BY booking_key-travel_id WITHOUT MEMBERS ( <booking> ) ) ).
    ENDIF.

  ENDMETHOD.

  METHOD validateStatus.

    READ ENTITY zi_travel_2860\\Booking
    FIELDS ( booking_status )
    WITH VALUE #( FOR <keyrow> in keys ( %key = <keyrow>-%key ) )
    result data(lt_booking_result).

    LOOP AT lt_booking_result INTO DATA(ls_booking_result).
      CASE ls_booking_result-booking_status.
        WHEN 'N'.
        WHEN 'X'.
        WHEN 'B'.
        WHEN OTHERS.
          APPEND VALUE #( %key = ls_booking_result-%key ) TO failed-travel.

          APPEND VALUE #( %key =  ls_booking_result-%key
                          %msg = new_message( id = 'Z_MC_TRAVEL_2860'
                                          number = '007'
                                              v1 = |{ ls_booking_result-booking_id ALPHA = OUT }|
                                        severity = if_abap_behv_message=>severity-error )
                         %element-booking_status = if_abap_behv=>mk-on ) TO reported-booking.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_travel_2860
    IN LOCAL MODE
    ENTITY booking
    FIELDS ( booking_id booking_date customer_id booking_status )
    WITH VALUE #( FOR keyval IN keys ( %key = keyval-%key ) )
    RESULT DATA(lt_booking_result).
    result = VALUE #( FOR ls_travel IN lt_booking_result
    ( %key = ls_travel-%key
      %assoc-_BookingSplmnt = if_abap_behv=>fc-o-enabled  ) ).
  ENDMETHOD.

ENDCLASS.
