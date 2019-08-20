defmodule Escpos.Commands do
  # ESC/POS _ (Constants)
  def lf(), do: "\x0a"
  def fs(), do: "\x1c"
  def ff(), do: "\x0c"
  def gs(), do: "\x1d"
  def dle(), do: "\x10"
  def eot(), do: "\x04"
  def nul(), do: "\x00"
  def esc(), do: "\x1b"
  def eol(), do: "\n"

  # [FEED_CONTROL_SEQUENCES Feed control sequences]
  # @type {Object}
  defmodule FeedControlSequences do
    # Print and line fee
    def lf(), do: "\x0a"
    # Print and feed paper (without spaces between lines
    def glf(), do: "\x4a\x00"
    # Form fee
    def ff(), do: "\x0c"
    # Carriage retur
    def cr(), do: "\x0d"
    # Horizontal ta
    def ht(), do: "\x09"
    # Vertical ta
    def vt(), do: "\x0b"
  end

  defmodule CharacterSpacing do
    def cs_default(), do: "\x1b\x20\x00"
    def cs_set(), do: "\x1b\x20"
  end

  defmodule LineSpacing do
    def ls_default(), do: "\x1b\x32"
    def ls_set(), do: "\x1b\x33"
  end

  # [HARDWARE Printer hardware]
  # @type {Object}
  defmodule Hardware do
    # Clear data in buffer and reset mode
    def init(), do: "\x1b\x40"
    # Printer selec
    def select(), do: "\x1b\x3d\x01"
    # Reset printer hardwar
    def reset(), do: "\x1b\x3f\x0a\x00"
  end

  # [CASH_DRAWER Cash Drawer]
  # @type {Object}
  defmodule CashDrawer do
    # Sends a pulse to pin 2 [
    def cd_kick_2(), do: "\x1b\x70\x00"
    # Sends a pulse to pin 5 [
    def cd_kick_5(), do: "\x1b\x70\x01"
  end

  # [MARGINS Margins sizes]
  # @type {Object}
  defmodule Margins do
    # Fix bottom siz
    def bottom(), do: "\x1b\x4f"
    # Fix left siz
    def left(), do: "\x1b\x6c"
    # Fix right siz
    def right(), do: "\x1b\x51"
  end

  # [PAPER Paper]
  # @type {Object}
  defmodule Paper do
    # Full cut pape
    def full_cut(), do: "\x1d\x56\x00"
    # Partial cut pape
    def part_cut(), do: "\x1d\x56\x01"
    # Partial cut pape
    def cut_a(), do: "\x1d\x56\x41"
    # Partial cut pape
    def cut_b(), do: "\x1d\x56\x42"
  end

  # [TEXT_FORMAT Text format]
  # @type {Object}
  defmodule TextFormat do
    # Normal tex
    def txt_normal(), do: "\x1b\x21\x00"
    # Double height tex
    def txt_2height(), do: "\x1b\x21\x10"
    # Double width tex
    def txt_2width(), do: "\x1b\x21\x20"
    # Double width & height tex
    def txt_4square(), do: "\x1b\x21\x30"

    # TXT_CUSTOM_SIZE: function (width, height) { # other sizes
    #   var widthDec = (width - 1) # 16;
    #   var heightDec = height - 1;
    #   var sizeDec = widthDec + heightDec;
    #   return '\x1d\x21' + String.fromCharCode(sizeDec);
    # },

    # TXT_HEIGHT: {
    #   1: '\x00',
    #   2: '\x01',
    #   3: '\x02',
    #   4: '\x03',
    #   5: '\x04',
    #   6: '\x05',
    #   7: '\x06',
    #   8: '\x07'
    # },
    # TXT_WIDTH: {
    #   1: '\x00',
    #   2: '\x10',
    #   3: '\x20',
    #   4: '\x30',
    #   5: '\x40',
    #   6: '\x50',
    #   7: '\x60',
    #   8: '\x70'
    # },

    # Underline font OF
    def txt_underl_off(), do: "\x1b\x2d\x00"
    # Underline font 1-dot O
    def txt_underl_on(), do: "\x1b\x2d\x01"
    # Underline font 2-dot O
    def txt_underl2_on(), do: "\x1b\x2d\x02"
    # Bold font OF
    def txt_bold_off(), do: "\x1b\x45\x00"
    # Bold font O
    def txt_bold_on(), do: "\x1b\x45\x01"
    # Italic font O
    def txt_italic_off(), do: "\x1b\x35"
    # Italic font O
    def txt_italic_on(), do: "\x1b\x34"

    # Font type
    def txt_font_a(), do: "\x1b\x4d\x00"
    # Font type
    def txt_font_b(), do: "\x1b\x4d\x01"
    # Font type
    def txt_font_c(), do: "\x1b\x4d\x02"

    # Left justificatio
    def txt_align_lt(), do: "\x1b\x61\x00"
    # Centerin
    def txt_align_ct(), do: "\x1b\x61\x01"
    # Right justificatio
    def txt_align_rt(), do: "\x1b\x61\x02"
  end

  #  # Qsprinter-compatible
  #  # Added by Attawit Kittikrairit
  #  # [MODEL Model-specific commands]
  #  # @type {Object}
  # _.MODEL = {
  #   QSPRINTER: {
  #     BARCODE_MODE: {
  #       ON: '\x1d\x45\x43\x01', # Barcode mode on
  #       OFF: '\x1d\x45\x43\x00', # Barcode mode off
  #     },
  #     BARCODE_HEIGHT_DEFAULT: '\x1d\x68\xA2', # Barcode height default:162
  #     CODE2D_FORMAT: {
  #       PIXEL_SIZE: {
  #         CMD: '\x1b\x23\x23\x51\x50\x49\x58',
  #         MIN: 1,
  #         MAX: 24,
  #         DEFAULT: 12,
  #       },
  #       VERSION: {
  #         CMD: '\x1d\x28\x6b\x03\x00\x31\x43',
  #         MIN: 1,
  #         MAX: 16,
  #         DEFAULT: 3,
  #       },
  #       LEVEL: {
  #         CMD: '\x1d\x28\x6b\x03\x00\x31\x45',
  #         OPTIONS: {
  #           L: 48,
  #           M: 49,
  #           Q: 50,
  #           H: 51,
  #         }
  #       },
  #       LEN_OFFSET: 3,
  #       SAVEBUF: {
  #         # Format: CMD_P1{LEN_2BYTE}CMD_P2{DATA}
  #         # DATA Max Length: 256*256 - 3 (65533)
  #         CMD_P1: '\x1d\x28\x6b',
  #         CMD_P2: '\x31\x50\x30',
  #       },
  #       PRINTBUF: {
  #         # Format: CMD_P1{LEN_2BYTE}CMD_P2
  #         CMD_P1: '\x1d\x28\x6b',
  #         CMD_P2: '\x31\x51\x30',
  #       }
  #     },
  #   },
  # };

  # [BARCODE_FORMAT Barcode format]
  # @type {Object}
  defmodule BarcodeFormat do
    # HRI barcode chars OF
    def barcode_txt_off(), do: "\x1d\x48\x00"
    # HRI barcode chars abov
    def barcode_txt_abv(), do: "\x1d\x48\x01"
    # HRI barcode chars belo
    def barcode_txt_blw(), do: "\x1d\x48\x02"
    # HRI barcode chars both above and belo
    def barcode_txt_bth(), do: "\x1d\x48\x03"

    # Font type A for HRI barcode char
    def barcode_font_a(), do: "\x1d\x66\x00"
    # Font type B for HRI barcode char
    def barcode_font_b(), do: "\x1d\x66\x01"

    # BARCODE_HEIGHT: function (height) { # Barcode Height [1-255]
    #   return '\x1d\x68' + String.fromCharCode(height);
    # },
    # # Barcode Width  [2-6]
    # BARCODE_WIDTH: {
    #   1: '\x1d\x77\x02',
    #   2: '\x1d\x77\x03',
    #   3: '\x1d\x77\x04',
    #   4: '\x1d\x77\x05',
    #   5: '\x1d\x77\x06',
    # },
    # Barcode height default:10
    def barcode_height_default(), do: "\x1d\x68\x64"
    # Barcode width default:
    def barcode_width_default(), do: "\x1d\x77\x01"

    # Barcode type UPC-
    def barcode_upc_a(), do: "\x1d\x6b\x00"
    # Barcode type UPC-
    def barcode_upc_e(), do: "\x1d\x6b\x01"
    # Barcode type EAN1
    def barcode_ean13(), do: "\x1d\x6b\x02"
    # Barcode type EAN
    def barcode_ean8(), do: "\x1d\x6b\x03"
    # Barcode type CODE3
    def barcode_code39(), do: "\x1d\x6b\x04"
    # Barcode type IT
    def barcode_itf(), do: "\x1d\x6b\x05"
    # Barcode type NW
    def barcode_nw7(), do: "\x1d\x6b\x06"
    # Barcode type CODE9
    def barcode_code93(), do: "\x1d\x6b\x48"
    # Barcode type CODE12
    def barcode_code128(), do: "\x1d\x6b\x49"
  end

  # [CODE2D_FORMAT description]
  # @type {Object}
  defmodule Code2DFormat do
    # def type_pdf417: _.gs + 'z' + '\x00',
    # type_datamatrix: _.gs + 'z' + '\x01',
    # type_qr: _.gs + 'z' + '\x02',
    # code2d: _.esc + 'z',
    # correct level 7
    def qr_level_l(), do: "L"
    # correct level 15
    def qr_level_m(), do: "M"
    # correct level 25
    def qr_level_q(), do: "Q"
    # correct level 30
    def qr_level_h(), do: "H"
  end

  # [IMAGE_FORMAT Image format]
  # @type {Object}
  defmodule ImageFormat do
    # Set raster image normal siz
    def s_raster_n(), do: "\x1d\x76\x30\x00"
    # Set raster image double widt
    def s_raster_2w(), do: "\x1d\x76\x30\x01"
    # Set raster image double heigh
    def s_raster_2h(), do: "\x1d\x76\x30\x02"
    # Set raster image quadrupl
    def s_raster_q(), do: "\x1d\x76\x30\x03"
  end

  # [BITMAP_FORMAT description]
  # @type {Object}

  defmodule BitmapFormat do
    def bitmap_s8(), do: "\x1b\x2a\x00"
    def bitmap_d8(), do: "\x1b\x2a\x01"
    def bitmap_s24(), do: "\x1b\x2a\x20"
    def bitmap_d24(), do: "\x1b\x2a\x21"
  end

  # [GSV0_FORMAT description]
  # @type {Object}
  defmodule Gsv0Format do
    def gsv0_normal(), do: "\x1d\x76\x30\x00"
    def gsv0_dw(), do: "\x1d\x76\x30\x01"
    def gsv0_dh(), do: "\x1d\x76\x30\x02"
    def gsv0_dwdh(), do: "\x1d\x76\x30\x03"
  end

  #  # [BEEP description]
  #  # @type {string}
  # _.BEEP = '\x1b\x42', # Printer Buzzer pre hex

  #  # [COLOR description]
  #  # @type {Object}
  # _.COLOR = {
  #   0: '\x1b\x72\x00', # black
  #   1: '\x1b\x72\x01', # red
  #   REVERSE: '\x1dB1', # Reverses the colors - white text on black background
  #   UNREVERSE: '\x1dB0' # Default: undo the reverse - black text on white background
  # };

  # [SCREEN description]
  # @type {Object}
  defmodule Screen do
    # Moves the cursor one character position to the lef
    def bs(), do: "\x08"
    # Moves the cursor one character position to the righ
    def ht(), do: "\x09"
    # Moves the cursor down one lin
    def lf(), do: "\x0a"
    # Moves the cursor up one lin
    def us_lf(), do: "\x1f\x0a"
    # Moves the cursor to the left-most position on the upper line (home position
    def hom(), do: "\x0b"
    # Moves the cursor to the left-most position on the current lin
    def cr(), do: "\x0d"
    # Moves the cursor to the right-most position on the current lin
    def us_cr(), do: "\x1f\x0d"
    # Moves the cursor to the bottom positio
    def us_b(), do: "\x1f\x42"
    # Moves the cursor to the nth position on the mth lin
    def us_n(), do: "\x1f\x24"
    # Clears all displayed character
    def clr(), do: "\x0c"
    # Clears the line containing the curso
    def can(), do: "\x18"
    # Selects overwrite mode as the screen display mod
    def us_md1(), do: "\x1f\x01"
    # Selects vertical scroll mode as the screen display mod
    def us_md2(), do: "\x1f\x02"
    # Selects horizontal scroll mode as the display screen mod
    def us_md3(), do: "\x1f\x03"
    # Turn cursor display mode on/of
    def us_c(), do: "\x1f\x43"
    # Sets or cancels the blink interval of the display scree
    def us_e(), do: "\x1f\x45"
    # Sets the counter time and displays it in the bottom right of the scree
    def us_t(), do: "\x1f\x54"
    # Displays the time counter at the right side of the bottom lin
    def us_u(), do: "\x1f\x55"
    # Sets the brightness of the fluorescent character display tub
    def us_x(), do: "\x1f\x58"
    # Selects or cancels reverse display of the characters received after this comman
    def us_r(), do: "\x1f\x72"
    # Sets the DTR signal in the host interface to the MARK or SPACE stat
    def us_v(), do: "\x1f\x76"
  end
end
