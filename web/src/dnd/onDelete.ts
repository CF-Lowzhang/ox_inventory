import { store } from '../store';
import { Slot } from '../typings';
import { fetchNui } from '../utils/fetchNui';

export const onDelete = (item: Slot) => {
  const {
    inventory: { itemAmount },
  } = store.getState();
  fetchNui('removeItem', { slot: item.slot, count: itemAmount });
};
