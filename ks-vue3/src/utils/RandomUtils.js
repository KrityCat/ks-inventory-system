import moment from 'moment'

export function randomId() {
  return moment().format('YYYY-MM-DD-HHmmss');
}

export function randomYear() {
  return moment().format('YYYY');
}

export function randomMouth() {
  return moment().format('YYYY-MM');
}