import { store } from '../store';
import { Slot } from '../typings';
import { fetchNui } from '../utils/fetchNui';

export const onChangeName = (item: Slot) => {
  const {
    inventory: { itemAmount },
  } = store.getState();
  fetchNui('onChangeName', { slot: item.slot});
};
