import { writable } from 'svelte/store';

/**
 * @typedef {Object} Investigation
 * @property {string} title
 * @property {string} description
 * @property {string} date
 * @property {string} author
 * @property {string[]} tags
 * @property {string} href
 */

/** @type {import('svelte/store').Writable<Investigation[]>} */
export const investigations = writable([]);
