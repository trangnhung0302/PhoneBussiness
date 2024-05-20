<template>

</template>

<script>
import { AccountService } from '../../../services/customer/account.service';

export default {
  data() {
    return {
      token: this.$router.history.current.params.token,
    }
  },
  mounted() {
    this.activeAccount();
  },
  methods: {
    async activeAccount() {
      const { response } = await AccountService.activeAccount(this.token);
      if (response.status === 'ok') {
        this.$router.push('/customer/register_success');
      }
      else {
        this.$router.push('/customer/verify_fail');
      }
    },
  },

}
</script>
