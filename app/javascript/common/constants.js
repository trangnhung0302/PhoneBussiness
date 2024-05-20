const SHOP_GHN_ID=4961549
const SHOP_GHN_DISTRICT_ID=1485

const paymentStatus = [
  { value: 'unpaid', name: 'Chưa thanh toán' },
  { value: 'wait_confirm', name: 'Chờ xác nhận' },
  { value: 'paid', name: 'Đã thanh toán' },
];
const orderStatus = [
  { value: 'wait_confirm', name: 'Chờ xác nhận' },
  { value: 'prepare', name: 'Chuẩn bị hàng' },
  { value: 'transporting', name: 'Đang vận chuyển' },
  { value: 'complete', name: 'Thành công' },
  { value: 'cancel', name: 'Đã hủy' },
];

export default {
  SHOP_GHN_ID,
  SHOP_GHN_DISTRICT_ID,
  paymentStatus,
  orderStatus,
};
