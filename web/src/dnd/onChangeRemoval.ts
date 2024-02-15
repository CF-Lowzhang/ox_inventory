import { store } from '../store';
import { Slot } from '../typings';
import { fetchNui } from '../utils/fetchNui';

export const onChangeRemoval = (item: Slot) => {
  const {
    inventory: { itemAmount },
  } = store.getState();
  fetchNui('onChangeRemoval', { slot: item.slot});
};
