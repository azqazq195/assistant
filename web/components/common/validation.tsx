import { useEffect } from 'react';

interface Props {
  isValid: boolean;
  errorMsg: string;
}

export const Validation = (props: Props) => {
  useEffect(() => {
    props.errorMsg;
  }, []);
  return (
    <div className="text-red-400 text-right text-sm">
      {!props.isValid && props.errorMsg}
    </div>
  );
};
