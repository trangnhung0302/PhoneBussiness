/**
 * Message defination
 */
export default {
  get: function (code, params) {
    let template = this[code] || '';
    for (const [key, value] of Object.entries(params)) {
      template = template.replace(new RegExp(`{${key}}`, 'g'), value);
    }
    return template;
  },

  // validation Thông báo lỗi
  1111: 'Vui lòng nhập đầy đủ {attr}',
  1112: '{attr}を選択してください。',
  1113: '{attr}を追加してください。',

  1121: '{attr} tối thiểu {min} ký tự',
  1122: '{attr} tối đa {max} ký tự',
  1123: '{attr}は{min}文字以上{max}文字以下で入力してください。',
  1124: '{attr}は{max}桁以下で入力してください。',
  1125: '{attr}は半角数字{length}桁で入力してください。',

  1131: '{attr}は{min}以上で入力してください。',
  1132: '{attr}は{max}以下で入力してください。',
  1133: '{attr}は{min}以上{max}以下で入力してください。',
  1134: '{attr}は{min} ～ {max}で入力してください。',
  1135: '{attr}は{max}より過去の日付で入力してください。',

  1141: 'Vui lòng nhập đúng định dạng {attr}',
  1142: '{attr}は英文字、数字、記号をそれぞれ１文字以上含んでください。',
  1143: '{attr} không khớp. Hãy thử lại.',
  1144: '{attr}に使用不可能な文字が含まれています。',

  1151: 'Vui lòng nhập {attr}',
  1152: '{attr}は半角英字で入力してください。',
  1153: '{attr}は半角英数字で入力してください。',
  1154: '{attr}は半角英数字記号で入力してください。',
  1155: '{attr}は全角カタカナで入力してください。',

  1161: '{attr}は{attr_to}より小さい値で入力してください。',
  1162: '{attr}は{attr_to}より後の時間で入力してください。',
  1163: '公開日時は非公開日時より前の日時を設定してください。',
  1164: '公開日時は現在の日時より前の日時を設定できません。',
  1165: '{attr}は{attr_to}の同日か先の日時を指定してください。',

  1171: '{attr}に重複した内容を入力しないでください。',

  1181: '無効な{attr}は選択できません。',

  1211: 'ファイル形式またはファイル拡張子が正しくありません。',
};
