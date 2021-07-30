unset multiplot;
set terminal wxt enhanced size 560,420 dashlength 2
set output '/dev/null';
set multiplot;

reset;
set autoscale keepfix;
set origin 0, 0
set size 1, 1
if (GPVAL_TERM eq "qt") set obj 1 rectangle from screen 0,0 to screen 1,1 behind fc rgb "#ffffff" fs solid noborder;
set obj 2 rectangle from graph 0,0 to graph 1,1 behind fc rgb "#ffffff" fs solid noborder
set border linecolor rgb "#000000"
unset tmargin;
unset bmargin;
unset lmargin;
unset rmargin;
set origin 0, 0;
set size noratio 1, 1;
unset label;
unset xtics;
unset ytics;
unset ztics;
unset x2tics;
unset y2tics;
set title "guf_noise/_QV_job.mat" font ":Bold,11" textcolor rgb "#000000" enhanced;
set xlabel "signal noise sigma" textcolor rgb "#262626" font ",11" enhanced rotate by 0.000000;
unset x2label;
set ylabel "THD (percent to main harm.)" textcolor rgb "#262626" font ",11" enhanced rotate by 90.000000;
unset y2label;
unset zlabel;
set grid noxtics;
set grid noytics;
set grid noztics;
set grid nomxtics;
set grid nomytics;
set grid nomztics;
set grid layerdefault;
set format x "%g";
set xtics in scale  1.4 border mirror textcolor rgb "#262626" font ",10";
unset mxtics;
set format y "%g";
set ytics in scale  1.4 border mirror textcolor rgb "#262626" font ",10";
unset mytics;
set format z "%g";
set ztics in scale  1.4 border mirror textcolor rgb "#262626" font ",10";
unset mztics;
unset logscale;
set clip two;
set style line 9 default;
set style line 9 linecolor rgb "#ff0000" dashtype solid linewidth 0.500000 pointtype 2 pointsize 2.000000;
set style line 10 default;
set style line 10 linecolor rgb "#ff0000" dashtype solid linewidth 0.500000 pointtype -1 pointsize 2.000000;
set style line 11 default;
set style line 11 linecolor rgb "#ff0000" dashtype solid linewidth 0.500000 pointtype -1 pointsize 2.000000;
set style line 12 default;
set style line 12 linecolor rgb "#0000ff" dashtype solid linewidth 0.500000 pointtype 2 pointsize 2.000000;
set style line 13 default;
set style line 13 linecolor rgb "#0000ff" dashtype solid linewidth 0.500000 pointtype -1 pointsize 2.000000;
set style line 14 default;
set style line 14 linecolor rgb "#0000ff" dashtype solid linewidth 0.500000 pointtype -1 pointsize 2.000000;
set pm3d implicit;
unset hidden3d;
set xrange [0.000000000000000e+00:1.000000000000000e+01];
set yrange [-1.000000000000000e+01:6.000000000000000e+01];
set cbrange [1:6.400000000000000e+01];
unset border
unset y2tics; set ytics in nomirror
unset x2tics; set xtics in nomirror
set border 0
set arrow 1 nohead nofilled front lc rgb "#262626" linewidth 0.500 from graph 0,0,0 to graph 1,0,0
set arrow 3 nohead nofilled front lc rgb "#262626" linewidth 0.500 from graph 0,0,0 to graph 0,1,0
unset grid;
set key inside right top;
set key box reverse Left vertical spacing 1.25 font ",10" textcolor rgb "#000000" enhanced;
set style data lines;
set palette positive color model RGB maxcolors 64;
set palette file "-" binary record=64 using 1:2:3:4;
  �?���>ظ�;��>   @��>R��<��>  @@���>�P=��>  �@׊�>���=���>  �@n��>S��=�$�>  �@2 �>�e�=���>  �@c̐>��>���>   A{��>lB!>���>  A���>��5>�$�>   A#��>I�I>���>  0A;�>��]>�?  @AR[�>�q>�?  PA�>}!�>��?  `A��>���>`S?  pA�y>̔>��	?  �A3�q>S؝>:�
?  �Aӽi>D��>��?  �A�a>k^�>�?  �AF�Y>?ܷ>�7?  �AB R>�/�>��?  �A�wJ>�]�>n?  �A�4C>]j�>�[?  �A*;<>GZ�>k�?  �A�5>�2�>O�?  �A}/>���>c�?  �A��(>���>q�?  �A\�">[�>��?  �A@�>� �>m�?  �A��>PQ?Ε?  �A��>v!?"M?  �A�>��
?��?   BQ�>P�?c[?  B�� >~�?t�?  B�0�=�d?0�?  B��=�5?j�
?  B���="?pk	?  B:��=��!?��?  BR�>�%?�?  Bv>0\)?f?   B<>/-?��?  $BS�)>��0?CV�>  (B��=>�h4?���>  ,B�U>��7?s�>  0B��n>�~;?��>  4Bbd�>��>?�`�>  8B�z�>�CB?��>  <B]��>�E?��>  @Bn�>|�H?q�>  DB�!�>ТK?�*�>  HB֐�>.�N?%@�>  LB���>	=Q?�>  PBd1 ?�S?���>  TB�S
?V<V?-Ύ>  XBQ�?f}X?T��>  \B�F?��Z?.�g>  `B�*?�\?�K>  dB��4?�B^?^�/>  hB�??��_?��>  lB��J?^^a?qg�=  pBISU?|�b?���=  tB}�_?�d?FG�=  xB�Pj?�^e?2��=  |B]pt?Q�f?-i�=  �B~E~?��g?d>
unset colorbox;
plot "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "wfft" with linespoints linestyle 9 \
, "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "neg" with linespoints linestyle 10 \
, "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "pos" with linespoints linestyle 11 \
, "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "mfsf" with linespoints linestyle 12 \
, "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "neg" with linespoints linestyle 13 \
, "-" binary format='%float64' record=2 using ($1):($2) axes x1y1 title "pos" with linespoints linestyle 14 \
;
�����ư>  Hk~�>      $@�j��8�B@�����ư>  �x'G+�      $@v�CS��5@�����ư> ��(O,?      $@��J@�����ư>   Eb���      $@`>��� @�����ư>g��P'��      $@^?L���#������ư>����>      $@^���9@
if (GPVAL_TERM eq "qt") unset obj 1;

unset multiplot;
