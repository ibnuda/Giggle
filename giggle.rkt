#lang racket

(define spacing 19)

(define cols 5)
(define rows 4)

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


(define (connector-shrouded x y rotation)
  `(module connector-shrouded (layer F.Cu) (tedit 200000)
	  (at ,x ,y ,rotation)
    (descr "PLATED THROUGH HOLE - 2X5 SHROUDED HEADER")
    (tags "PLATED THROUGH HOLE - 2X5 SHROUDED HEADER")
	  (attr virtual)
	  (fp_text reference >NAME (at 5.207 -5.08 90) (layer F.SilkS)
	    (effects (font (size 0.6096 0.6096) (thickness 0.127)))
	  )
	  (fp_text value >VALUE (at -5.08 -5.08 90) (layer F.SilkS)
	    (effects (font (size 0.6096 0.6096) (thickness 0.127)))
	  )
	  (fp_line (start -1.524 -4.826) (end -1.016 -4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 -4.826) (end -1.016 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -5.334) (end -1.016 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -4.826) (end -1.524 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -4.826) (end 1.524 -4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 -4.826) (end 1.524 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -5.334) (end 1.524 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -4.826) (end 1.016 -5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -2.286) (end 1.524 -2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 -2.286) (end 1.524 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -2.794) (end 1.524 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -2.286) (end 1.016 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -2.286) (end -1.016 -2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 -2.286) (end -1.016 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -2.794) (end -1.016 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -2.286) (end -1.524 -2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 0.254) (end 1.524 0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 0.254) (end 1.524 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 -0.254) (end 1.524 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 0.254) (end 1.016 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 0.254) (end -1.016 0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 0.254) (end -1.016 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 -0.254) (end -1.016 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 0.254) (end -1.524 -0.254) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.794) (end 1.524 2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 2.794) (end 1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.286) (end 1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.794) (end 1.016 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.794) (end -1.016 2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 2.794) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.286) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.794) (end -1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 5.334) (end 1.524 5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 5.334) (end 1.524 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 4.826) (end 1.524 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 5.334) (end 1.016 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 5.334) (end -1.016 5.334) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 5.334) (end -1.016 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 4.826) (end -1.016 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 5.334) (end -1.524 4.826) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.794) (end -1.016 2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.016 2.794) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.286) (end -1.016 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start -1.524 2.794) (end -1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.794) (end 1.524 2.794) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.524 2.794) (end 1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.286) (end 1.524 2.286) (layer Dwgs.User) (width 0.06604))
	  (fp_line (start 1.016 2.794) (end 1.016 2.286) (layer Dwgs.User) (width 0.06604))
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
	  (pad 1 thru_hole circle (at -1.27 -5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 2 thru_hole circle (at 1.27 -5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 3 thru_hole circle (at -1.27 -2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 4 thru_hole circle (at 1.27 -2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 5 thru_hole circle (at -1.27 0) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 6 thru_hole circle (at 1.27 0) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 7 thru_hole circle (at -1.27 2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 8 thru_hole circle (at 1.27 2.54) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 9 thru_hole circle (at -1.27 5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))
	  (pad 10 thru_hole circle (at 1.27 5.08) (size 1.8796 1.8796) (drill 1.016) (layers *.Cu *.Mask) (solder_mask_margin 0.1016))))

(define nets
  `((net 0 "")
    (net 1  N-row-0)
    (net 2  N-row-1)
    (net 3  N-row-2)
    (net 4  N-row-3)
    (net 5  N-col-0)
    (net 6  N-col-1)
    (net 7  N-col-2)
    (net 8  N-col-3)
    (net 9  N-col-4)
    ,@(for/list ([s (in-range 20)])
        (list 'net (+ 10 s) (string->symbol (format "N-diode-~s" s))))))

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

(define (switch row col)
  (let* ([x (* (+ 1 col) spacing)]
         [y (+ 40 (* row spacing))]
         [label (format "sw~a:~a" col row)]
         [rotation 0]
         [diode (+ row (* col 4))]
         [diode-net `(net ,(+ 10 diode) ,(string->symbol (format "N-diode-~s" diode)))]
         [column-net `(net ,(+ 5 col) ,(string->symbol (format "N-col-~s" col)))])
    (switch-module x y rotation label column-net diode-net)))

(define (diode row col)
  (let* ([x (+ 9 (* (+ 1 col) spacing))]
         [y (+ 40 (* row spacing))]
         [label (format "d~a:~a" col row)]
         [rotation 0]
         [diode (+ row (* col 4))]
         [diode-net `(net ,(+ 10 diode) ,(string->symbol (format "N-diode-~s" diode)))]
         [row-net `(net ,(+ 1 row) ,(string->symbol (format "N-row-~s" row)))])
    (diode-module x y rotation label diode-net row-net)))

(define switches+diodes
  (for/list ([col (in-range cols)]
             #:when true
             [row (in-range rows)])
    (list (switch row col) (diode row col))))

(define edge-cuts
  (for/list [(s '([10  10] [110 10]  [110 110] [10 110]))
             (e '([110 10] [110 110] [10  110] [10 10]))]
    `(gr_line (start ,@s) (end ,@e) (angle 90) (layer Edge.Cuts) (width 0.3))))

(define board
  (apply append nets
								(list (net-class nets))
								(list (connector-shrouded (* spacing 4.5) 20 90))
							  edge-cuts
                switches+diodes
                ))

(define (write-placement filename)
  (when (file-exists? filename) (delete-file filename))
  (call-with-output-file filename
    (λ (op)
      (display (call-with-input-file "header.rktd"
                 (curry read-string 9999)) op)
      (display "\n" op)
      (for ([f board])
        (pretty-print f op 1))
      (display (call-with-input-file "traces.rktd"
                 (curry read-string 999999)) op)
      (display ")" op))))

(write-placement "giggle.kicad_pcb")
