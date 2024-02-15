import { store } from '../store';
import { Slot } from '../typings';
import { fetchNui } from '../utils/fetchNui';

export const onChangeDesc = (item: Slot) => {
  const {
    inventory: { itemAmount },
  } = store.getState();
  fetchNui('onChangeDesc', { slot: item.slot});
};
