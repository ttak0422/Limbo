{{_expr_:substitute(get(g:, 'sonic_license_header', ''), 'FILE_NAME', '{{_name_}}.java', 'g')}}

{{_lang_util_:package}}

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum {{_expr_:substitute('{{_name_}}', '\w\+', '\u\0', '')}} {
  {{_cursor_}}(),
  ;

  /** value. */
  private final String value;

  /** label. */
  private final String label;
}
