#lang racket

(define spacing 19)

(define side-cols 5)
(define side-rows 4)

(define main-cols 4)
(define main-rows 3)

(define is-staggered true)

(define column-offset (if is-staggered '(10 5 0 5 10) '(9 9 9 9 9)))

(define (switch-module x y rotation label net-pos net-neg)
  `(module MX_FLIP (layer Front) (tedit 4FD81CDD) (tstamp 543EF801)
     (at ,x ,y ,rotation)
     (path /543DB910) ; TODO: this is not documented; no idea what it does
     (fp_text reference ,label (at 0 3.302 ,rotation) (layer F.SilkS) (effects (font (size 1.524 1.778) (thickness 0.254))))
     (fp_line (start -7 -7) (end  7 -7) (layer F.SilkS) (width 0.381))
     (fp_line (start  7 -7) (end  7  7) (layer F.SilkS) (width 0.381))
     (fp_line (start  7  7) (end -7  7) (layer F.SilkS) (width 0.381))
     (fp_line (start -7  7) (end -7 -7) (layer F.SilkS) (width 0.381))
     (pad 0 np_thru_hole circle (at 0 0) (size 3.9878 3.9878) (drill 3.9878)) ; switch hole, no copper
     (pad 0 np_thru_hole circle (at -5.08 0) (size 1.7018 1.7018) (drill 1.7018)) ; board-mount hole, no copper
     (pad 0 np_thru_hole circle (at 5.08 0) (size 1.7018 1.7018) (drill 1.7018)) ; board-mount hole, no copper
     (pad 1 thru_hole circle (at 2.54 -5.08) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask) ,net-pos)
     (pad 1 thru_hole circle (at 3.81 -2.54) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask) ,net-pos)
     (pad 2 thru_hole circle (at -2.54 -5.08) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask) ,net-neg)
     (pad 2 thru_hole circle (at -3.81 -2.54) (size 2.286 2.286) (drill 1.4986) (layers *.Cu *.SilkS *.Mask) ,net-neg)))

(define (diode-module x y rotation label net-pos net-neg)
  `(module DIODE (layer Front) (tedit 4E0F7A99) (tstamp 543EF854)
     (at ,x ,y ,(+ 90 rotation))
     (path /543DB90F)
     (fp_text reference ,label (at 0 0 ,rotation) (layer F.SilkS) hide (effects (font (size 1.016 1.016) (thickness 0.2032))))
     (fp_line (start 0.9 1.1) (end 0.9 -1.1) (layer F.SilkS) (width 0.15))
     (fp_line (start 1.1 -1.1) (end 1.1 1.1) (layer F.SilkS) (width 0.15))
     (fp_line (start 1.3 -1) (end 1.3 -1.1) (layer F.SilkS) (width 0.15))
     (fp_line (start 1.3 -1.1) (end 1.3 -1) (layer F.SilkS) (width 0.15))
     (fp_line (start 1.3 1.1) (end 1.3 -1) (layer F.SilkS) (width 0.15))
     (fp_line (start -1.524 -1.143) (end 1.524 -1.143) (layer F.SilkS) (width 0.2032))
     (fp_line (start 1.524 -1.143) (end 1.524 1.143) (layer F.SilkS) (width 0.2032))
     (fp_line (start 1.524 1.143) (end -1.524 1.143) (layer F.SilkS) (width 0.2032))
     (fp_line (start -1.524 1.143) (end -1.524 -1.143) (layer F.SilkS) (width 0.2032))

     (pad 1 thru_hole rect (at 3.5 0 ,(+ 90 rotation)) (size 1.6 1.6) (drill 1) (layers *.Cu *.Mask F.SilkS) ,net-pos)
     (pad 2 thru_hole circle (at -3.5 0 ,(+ 90 rotation)) (size 1.6 1.6) (drill 1) (layers *.Cu *.Mask F.SilkS) ,net-neg)))


(define (microcontroller-module x y rotation)
  `(module PROMICRO (layer Front) (tedit 4FDC31C8) (tstamp 543EF800)
     (at ,x ,y ,rotation)
     (path /543EEB02)
     (fp_text reference Promicro (at 10 0) (layer F.SilkS) (effects (font (size 1 1) (thickness 0.15))))
     (fp_line (start -15.24 7.62) (end 15.9 7.62) (layer F.SilkS) (width 0.381))
     (fp_line (start 15.9 7.62) (end 15.9 -7.62) (layer F.SilkS) (width 0.381))
     (fp_line (start 15.9 -7.62) (end -15.24 -7.62) (layer F.SilkS) (width 0.381))
     (pad B5  thru_hole circle (at  13.97 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  4 N-row-3))
     (pad B4  thru_hole circle (at  11.43 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  3 N-row-2))
     (pad E6  thru_hole circle (at   8.89 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 11 N-col-6))
     (pad D7  thru_hole circle (at   6.35 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 12 N-col-7))
     (pad C6  thru_hole circle (at   3.81 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 13 N-col-8))
     (pad D4  thru_hole circle (at   1.27 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 17 N-col-12))
     (pad D0  thru_hole circle (at  -1.27 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 16 N-col-11) )
     (pad D1  thru_hole circle (at  -3.81 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 15 N-col-10))
     (pad GND thru_hole circle (at  -6.35 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
     (pad GND thru_hole circle (at  -8.89 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
     (pad RX1 thru_hole circle (at -11.43 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 14 N-col-9))
     (pad TX0 thru_hole rect   (at -13.97 -7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 18 N-col-13))

     (pad B6  thru_hole circle (at  13.97  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  1 N-row-0))
     (pad B2  thru_hole circle (at  11.43  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  2 N-row-1))
     (pad B3  thru_hole circle (at   8.89  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  9 N-col-4))
     (pad B1  thru_hole circle (at   6.35  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  5 N-col-0))
     (pad F7  thru_hole circle (at   3.81  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  6 N-col-1))
     (pad F6  thru_hole circle (at   1.27  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  7 N-col-2))
     (pad F5  thru_hole circle (at  -1.27  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net  8 N-col-3))
     (pad F4  thru_hole circle (at  -3.81  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask) (net 10 N-col-5))
     (pad VCC thru_hole circle (at  -6.35  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
     (pad RST thru_hole circle (at  -8.89  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
     (pad GND thru_hole circle (at -11.43  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))
     (pad RAW thru_hole circle (at -13.97  7.62 270) (size 1.7526 1.7526) (drill 1.0922) (layers *.Cu *.SilkS *.Mask))))

(define (connector-shrouded x y rotation r v np1 np2 np3 np4 np5 np6 np7 np8 np9)
  `(module connector-shrouded (layer F.Cu) (tedit 200000)
     (at ,x ,y ,rotation)
     (descr "PLATED THROUGH HOLE - 2X5 SHROUDED HEADER")
     (tags "PLATED THROUGH HOLE - 2X5 SHROUDED HEADER")
     (attr virtual)
     (fp_text reference ,r (at 5.207 -5.08) (layer F.SilkS)
              (effects (font (size 0.6096 0.6096) (thickness 0.127)))
              )
     (fp_text value ,v (at -5.08 -5.08) (layer F.SilkS)
              (effects (font (size 0.6096 0.6096) (thickness 0.127)))
              )
     (fp_line (start -1.524 -4.826) (end -1.016 -4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016 -4.826) (end -1.016 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -5.334) (end -1.016 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -4.826) (end -1.524 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -4.826) (end  1.524 -4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524 -4.826) (end  1.524 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -5.334) (end  1.524 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -4.826) (end  1.016 -5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -2.286) (end  1.524 -2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524 -2.286) (end  1.524 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -2.794) (end  1.524 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -2.286) (end  1.016 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -2.286) (end -1.016 -2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016 -2.286) (end -1.016 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -2.794) (end -1.016 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -2.286) (end -1.524 -2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016  0.254) (end  1.524  0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524  0.254) (end  1.524 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 -0.254) (end  1.524 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016  0.254) (end  1.016 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524  0.254) (end -1.016  0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016  0.254) (end -1.016 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 -0.254) (end -1.016 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524  0.254) (end -1.524 -0.254) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.794) (end  1.524 2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524 2.794) (end  1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.286) (end  1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.794) (end  1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.794) (end -1.016 2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016 2.794) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.286) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.794) (end -1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 5.334) (end  1.524 5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524 5.334) (end  1.524 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 4.826) (end  1.524 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 5.334) (end  1.016 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 5.334) (end -1.016 5.334) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016 5.334) (end -1.016 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 4.826) (end -1.016 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 5.334) (end -1.524 4.826) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.794) (end -1.016 2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.016 2.794) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.286) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -1.524 2.794) (end -1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.794) (end  1.524 2.794) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.524 2.794) (end  1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.286) (end  1.524 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start  1.016 2.794) (end  1.016 2.286) (layer Dwgs.User) (width 0.06604))
     (fp_line (start -2.77368 -5.715) (end -2.77368 -4.445) (layer F.SilkS) (width 0.2032))
     (fp_line (start 4.49834 -10.09904) (end 4.49834 10.09904) (layer F.SilkS) (width 0.2032))
     (fp_line (start -4.49834 10.09904) (end -4.49834 2.19964) (layer F.SilkS) (width 0.2032))
     (fp_line (start -4.49834 2.19964) (end -4.49834 -2.19964) (layer F.SilkS) (width 0.2032))
     (fp_line (start -4.49834 -2.19964) (end -4.49834 -10.09904) (layer F.SilkS) (width 0.2032))
     (fp_line (start -4.49834 -10.09904) (end 4.39928 -10.09904) (layer F.SilkS) (width 0.2032))
     (fp_line (start 4.49834 10.09904) (end -4.49834 10.09904) (layer F.SilkS) (width 0.2032))
     (fp_line (start -3.39852 -8.99922) (end 3.39852 -8.99922) (layer Dwgs.User) (width 0.2032))
     (fp_line (start 3.39852 -8.99922) (end 3.39852 8.99922) (layer Dwgs.User) (width 0.2032))
     (fp_line (start -3.39852 8.99922) (end 3.39852 8.99922) (layer Dwgs.User) (width 0.2032))
     (fp_line (start -4.49834 -2.19964) (end -2.99974 -2.19964) (layer F.SilkS) (width 0.2032))
     (fp_line (start -2.99974 -2.19964) (end -2.99974 2.19964) (layer F.SilkS) (width 0.2032))
     (fp_line (start -2.99974 2.19964) (end -4.49834 2.19964) (layer F.SilkS) (width 0.2032))
     (fp_line (start -3.39852 -8.99922) (end -3.39852 -2.19964) (layer Dwgs.User) (width 0.2032))
     (fp_line (start -3.39852 8.99922) (end -3.39852 2.19964) (layer Dwgs.User) (width 0.2032))
     (fp_line (start -2.81178 -5.715) (end -2.81178 -4.445) (layer F.SilkS) (width 0.2032))
     (pad 1 thru_hole circle (at -1.27 -5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np1 (solder_mask_margin 0.1016))
     (pad 2 thru_hole circle (at 1.27 -5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np2 (solder_mask_margin 0.1016))
     (pad 3 thru_hole circle (at -1.27 -2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np3 (solder_mask_margin 0.1016))
     (pad 4 thru_hole circle (at 1.27 -2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np4 (solder_mask_margin 0.1016))
     (pad 5 thru_hole circle (at -1.27 0) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np5 (solder_mask_margin 0.1016))
     (pad 6 thru_hole circle (at 1.27 0) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np6 (solder_mask_margin 0.1016))
     (pad 7 thru_hole circle (at -1.27 2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np7 (solder_mask_margin 0.1016))
     (pad 8 thru_hole circle (at 1.27 2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np8 (solder_mask_margin 0.1016))
     (pad 9 thru_hole circle (at -1.27 5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          ,np9 (solder_mask_margin 0.1016))
     (pad 10 thru_hole circle (at 1.27 5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask)
          (solder_mask_margin 0.1016))))

(define nets
  `((net  0  "")
    (net  1  N-row-0)
    (net  2  N-row-1)
    (net  3  N-row-2)
    (net  4  N-row-3)
    (net  5  N-col-0)
    (net  6  N-col-1)
    (net  7  N-col-2)
    (net  8  N-col-3)
    (net  9  N-col-4)
    (net 10  N-col-5)
    (net 11  N-col-6)
    (net 12  N-col-7)
    (net 13  N-col-8)
    (net 14  N-col-9)
    (net 15  N-col-10)
    (net 16  N-col-11)
    (net 17  N-col-12)
    (net 18  N-col-13)
    ,@(for/list ([s (in-range (+ (* side-cols side-rows 2) (* main-cols main-rows)))])
        (list 'net (+ 19 s) (string->symbol (format "N-diode-~s" s))))))

(define (net-class nets)
  (append '(net_class Default "This is the default net class."
                      (clearance 0.254)
                      (trace_width 0.2032)
                      (via_dia 0.889)
                      (via_drill 0.635)
                      (uvia_dia 0.508)
                      (uvia_drill 0.127))
          (for/list ([n nets])
            (list 'add_net (last n)))))

(define (switch row col x-pad y-pad is-main col-pad)
  (let* ([x (+ x-pad (* col spacing))]
         [y (+ y-pad (* row spacing) (if is-main 0 (list-ref column-offset col)))]
         [label (format "sw~a:~a" col row)]
         [rotation 0]
         [diode (+ row (* col 4))]
         [diode-net `(net ,(+ 19 diode) ,(string->symbol (format "N-diode-~s" diode)))]
         [column-net `(net ,(+ col-pad 5 col) ,(string->symbol (format "N-col-~s" (+ col-pad col))))])
    (switch-module x y rotation label diode-net column-net)))

(define (diode row col x-pad y-pad is-main)
  (let* ([x (+ x-pad (* col spacing))]
         [y (+ y-pad (* row spacing) (if is-main 0 (list-ref column-offset col)))]
         [label (format "d~a:~a" col row)]
         [rotation 0]
         [diode (+ row (* col 4))]
         [diode-net `(net ,(+ 19 diode) ,(string->symbol (format "N-diode-~s" diode)))]
         [row-net `(net ,(+ 1 row) ,(string->symbol (format "N-row-~s" row)))])
    (diode-module x y rotation label diode-net row-net)))

(define side-switches+diodes
  (for/list ([col (in-range side-cols)]
             #:when true
             [row (in-range side-rows)])
    (list (switch row col 38.1 47.15 false 0) (diode row col 46.1 47.15 false))))

(define main-switches+diodes
  (for/list ([col (in-range main-cols)]
             #:when true
             [row (in-range main-rows)])
    (list (switch row col 47.6 76.15 true side-cols) (diode row col 55.6 76.15 true))))

(define straight-edge-cuts
  (for/list [(s '([122   28] [125  31] [27.5  31] [122   125]))
             (e '([ 30.5 28] [125 122] [27.5 122] [ 30.5 125]))]
    `(gr_line (start ,@s) (end ,@e) (angle 90) (layer Edge.Cuts) (width 0.3))))

(define arc-edge-cuts
  (for/list [(s '([122 31] [30.5 31] [122 122] [30.5  122]))
             (e '([125 31] [30.5 28] [122 125] [27.5  122]))]
    `(gr_arc (start ,@s) (end ,@e) (angle -90) (layer Edge.Cuts) (width 0.3))))

(define side-board
  (apply append nets
         (list (net-class nets))
         (list (connector-shrouded 40 38.5 270 "J1" "CONN_05X2SHD" `(net 1 N-row-0)
                                   `(net 8 N-col-3)
                                   `(net 2 N-row-1)
                                   `(net 7 N-col-2)
                                   `(net 3 N-row-2)
                                   `(net 6 N-col-1)
                                   `(net 4 N-row-3)
                                   `(net 5 N-col-0)
                                   `(net 9 N-col-4)))
         (list (connector-shrouded 113.5 38.5 270 "J2" "CONN_05X2SHD" `(net 1 N-row-0)
                                   `(net 8 N-col-3)
                                   `(net 2 N-row-1)
                                   `(net 7 N-col-2)
                                   `(net 3 N-row-2)
                                   `(net 6 N-col-1)
                                   `(net 4 N-row-3)
                                   `(net 5 N-col-0)
                                   `(net 9 N-col-4)))
         straight-edge-cuts
         arc-edge-cuts
         side-switches+diodes))

(define main-board
  (apply append nets
         (list (connector-shrouded 40 38.5 270 "J2" "CONN_05X2SHD"
                                   `(net 1 N-row-0)
                                   `(net 8 N-col-3)
                                   `(net 2 N-row-1)
                                   `(net 7 N-col-2)
                                   `(net 3 N-row-2)
                                   `(net 6 N-col-1)
                                   `(net 4 N-row-3)
                                   `(net 5 N-col-0)
                                   `(net 9 N-col-4)))
         (list (connector-shrouded 113.5 38.5 270 "J1" "CONN_05X2SHD"
                                   `(net  1 N-row-0)
                                   `(net 17 N-col-12)
                                   `(net  2 N-row-1)
                                   `(net 16 N-col-11)
                                   `(net  3 N-row-2)
                                   `(net 15 N-col-10)
                                   `(net  4 N-row-3)
                                   `(net 14 N-col-9)
                                   `(net 18 N-col-13)))
         (list (microcontroller-module 76.25 46 270))
         straight-edge-cuts
         arc-edge-cuts
         main-switches+diodes))

(define (write-placement boardname pcbname headerfile tracesfile)
  (when (file-exists? pcbname) (delete-file pcbname))
  (call-with-output-file pcbname
    (λ (op)
      (display (call-with-input-file headerfile
                 (curry read-string 9999)) op)
      (display "\n" op)
      (for ([f boardname])
        (pretty-print f op 1))
      (display (call-with-input-file tracesfile
                 (curry read-string 999999)) op)
      (display ")" op))))

(write-placement side-board "giggle-side.kicad_pcb" "header-side.rktd" "traces-side.rktd")
(write-placement main-board "giggle-main.kicad_pcb" "header-main.rktd" "traces-main.rktd")
