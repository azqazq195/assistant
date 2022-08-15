import React, { Fragment } from 'react';
import { Transition, Dialog as ADialog } from '@headlessui/react';

interface Props {
  title: string;
  show: boolean;
  initialFocus?: React.MutableRefObject<HTMLElement | null> | undefined;
  onClose?: void;
}

export const Dialog = (props: Props, { content }: any) => {
  return (
    <Transition.Root show={props.show} as={Fragment}>
      <ADialog
        as="div"
        className="relative z-10"
        initialFocus={props.initialFocus}
        onClose={() => props.onClose}
      >
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
        </Transition.Child>

        <div className="fixed z-10 inset-0 overflow-y-auto">
          <div className="flex items-end sm:items-center justify-center min-h-full p-4 text-center sm:p-0">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
              enterTo="opacity-100 translate-y-0 sm:scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 translate-y-0 sm:scale-100"
              leaveTo="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            >
              <ADialog.Panel className="relative bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:max-w-lg sm:w-full">
                <div className="sm:flex sm:items-start bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4 flex flex-col">
                  <ADialog.Title
                    as="h3"
                    className="text-center sm:mt-0 sm:mb-4 sm:text-left text-lg leading-6 font-bold text-gray-900"
                  >
                    {props.title}
                  </ADialog.Title>
                  {content}
                </div>
              </ADialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </ADialog>
    </Transition.Root>
  );
};
