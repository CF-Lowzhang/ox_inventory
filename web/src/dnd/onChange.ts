import { store } from '../store';
import { Slot } from '../typings';
import { fetchNui } from '../utils/fetchNui';

export const onChange = (item: Slot) => {
  const {
    inventory: { itemAmount },
  } = store.getState();
  fetchNui('onChange', { slot: item.slot});
};
