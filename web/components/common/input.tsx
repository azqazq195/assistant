import React from 'react';

interface Props {
  name: string;
  displayName: string;
  type: string;
  value: string;
  onChange: (event: React.ChangeEvent<HTMLInputElement>) => void;
}

export const Input = (props: Props) => {
  return (
    <>
      <input
        name={props.name}
        type={props.type}
        value={props.value}
        placeholder={props.displayName}
        onChange={(event) => {
          props.onChange(event);
        }}
        className="
        mb-3 
        w-full 
        text-xs 
        bg-white 
        rounded 
        border 
        border-gray-300 
        focus:border-indigo-500 
        focus:ring-2 
        focus:ring-indigo-200  
        outline-none 
        text-gray-700 
        py-1 
        px-3 
        leading-7 
        transition-colors 
        duration-200 
        ease-in-out"
      />
    </>
  );
};
