<template>
  <Doughnut
    v-if="chartData.labels.length > 0"
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :plugins="plugins"
    :css-classes="cssClasses"
    :styles="styles"
    :width="width"
    :height="height"
  />
  <div v-else class="text-danger">Chưa có dữ liệu</div>
</template>

<script>
import { Doughnut } from 'vue-chartjs/legacy'

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  CategoryScale
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

export default {
  name: 'DoughnutChart',
  components: {
    Doughnut
  },
  props: {
    chartId: {
      type: String,
      default: 'doughnut-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 400
    },
    height: {
      type: Number,
      default: 400
    },
    cssClasses: {
      default: '',
      type: String
    },
    styles: {
      type: Object,
      default: () => {}
    },
    plugins: {
      type: Array,
      default: () => []
    },
    data: {
      type: Array,
      default: () => [],
    }
  },
  data() {
    return {
      chartData: {
        labels: [],
        datasets: [
          {
            backgroundColor: [],
            data: []
          }
        ]
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false
      }
    }
  },
  watch: {
    data(value) {
      const labels = [];
      const newData = [];
      const color = [];
      value.forEach(element => {
        labels.push(element.label);
        newData.push(element.data);
        color.push(this.randomColor(color));
      });
      this.chartData = {
        labels: labels,
        datasets: [
          {
            backgroundColor: color,
            data: newData
          }
        ]
      }
    }
  },
  methods: {
    randomColor(color) {
      let newColor = Math.floor(Math.random()*16777215).toString(16);
      while (color.includes(newColor)) {
        newColor = Math.floor(Math.random()*16777215).toString(16);
      }
      return `#${newColor}`;
    }
  },
}
</script>
