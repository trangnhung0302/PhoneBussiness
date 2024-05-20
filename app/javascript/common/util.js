export default {
  convertNumberFormat: (value) => {
    const formatter = new Intl.NumberFormat('vi-VN');
    return formatter.format(value);
  }
};

export const SafeTrim = (value) => {
  return (typeof value === 'string') ? value.trim() : value;
};
